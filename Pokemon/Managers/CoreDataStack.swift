//
//  CoreDataStackManagible.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import UIKit
import CoreData

enum CoreDataModel: String, CaseIterable {
    case pokemon = "Pokemon"
}

/// Protocol defining the requirements for managing the CoreData stack
protocol CoreDataStackManagible: AnyObject {
    
    var managedContext: NSManagedObjectContext { get }
    var newBackgroundContext: NSManagedObjectContext { get }
    
    /// Saves changes made in the managed context
    func saveContext() throws
    
    var ignoreCoreDataNoChangeError: Bool { get }
    var savesChangesOnAppBackground: Bool { get }
    var shouldDeleteInaccessibleFaults: Bool { get }
}

/// Class responsible for managing the CoreData stack
class CoreDataStack {
    
    private let model: CoreDataModel
    private (set)var storeLoadError: NSError?
    
    var ignoreCoreDataNoChangeError: Bool { true }
    var savesChangesOnAppBackground: Bool { false }
    var shouldDeleteInaccessibleFaults: Bool { true }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: model.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                self.storeLoadError = error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.shouldDeleteInaccessibleFaults = self.shouldDeleteInaccessibleFaults
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = { self.storeContainer.viewContext }()
    
    lazy var newBackgroundContext: NSManagedObjectContext = { self.storeContainer.newBackgroundContext() }()
    
    
    init(model: CoreDataModel) {
        self.model = model
        NotificationCenter.addDefaultObserver(name: .userDefinedNotification(.saveCoreDataStackInfo), observer: self, selector: #selector(saveChanges))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: CoreDataStackManagible

extension CoreDataStack: CoreDataStackManagible {
    
    // MARK: - Core Data Saving support

    /// Saves changes made in the managed context. Throws an error if there are no changes to save.
    func saveContext() throws {
        let context = managedContext
        guard context.hasChanges else {
            if ignoreCoreDataNoChangeError {
                return
            }
            throw Error.noChanges
        }
        do {
            try context.save()
        } catch {
            throw Error.custom(error.localizedDescription)
        }
    }
}

// MARK: Helper func's

private extension CoreDataStack {

    @objc func saveChanges() {
        if UIApplication.shared.applicationState == .background {
            guard savesChangesOnAppBackground else { return }
            try? saveContext()
        } else {
            try? saveContext()
        }
    }
}

extension CoreDataStack {
    
    /// Enum defining possible errors related to CoreData operations
    enum Error: ErrorShowable {
        case noChanges
        case custom(String)
        
        var showableDescription: String {
            switch self {
            case .custom(let errorDesc):
                return errorDesc
            case .noChanges:
                return "No Core Data Changes"
            }
        }
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

public typealias CoreDataAsynchronousFetchResult<T: NSFetchRequestResult> = ((NSAsynchronousFetchResult<T>) -> Void)?

extension NSManagedObject {
    
    @nonobjc
    public class func coreFetchRequest<T>(expectedType: T.Type = T.self,_ entityName: String = "\(T.self)") -> NSFetchRequest<T> {
        NSFetchRequest<T>(entityName: entityName)
    }
    
    @nonobjc
    public class func coreFetchAsyncRequest<T>(
        _ request: NSFetchRequest<T>,
        onCompletion: CoreDataAsynchronousFetchResult<T>
    ) -> NSAsynchronousFetchRequest<T> {
        NSAsynchronousFetchRequest<T>.init(fetchRequest: request,completionBlock: onCompletion)
    }
    
    @nonobjc
    public class func coreFetchAsyncRequest<T>(
        _ request: NSFetchRequest<T>,
        in context: NSManagedObjectContext
    ) async throws -> [T] {
        return try await withCheckedThrowingContinuation { continuation in
            let request = NSAsynchronousFetchRequest<T>.init(fetchRequest: request) { request in
                if let result = request.finalResult {
                    continuation.resume(with: .success(result))
                } else {
                    continuation.resume(with: .failure(CoreDataStack.Error.custom("Unable to get desired Results, Something went wrong!")))
                }
            }
            do {
                try context.execute(request)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
