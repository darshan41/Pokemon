//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import UIKit
import CoreData



enum CoreDataModel: String,CaseIterable {
    case pokemon = "Pokemon"
}

protocol CoreDataStackManagible {
    
    var managedContext: NSManagedObjectContext { get }
    var newBackgroundContext: NSManagedObjectContext { get }
    
    func saveContext() throws
    
    var ignoreCoreDataNoChangeError: Bool { get }
    var savesChangesOnAppBackground: Bool { get }
    var shouldDeleteInaccessibleFaults: Bool { get }
}

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

public typealias CoreDataAsynchronousFetchRequest<T: NSFetchRequestResult> = ((NSAsynchronousFetchRequest<T>) -> Void)?

public typealias CoreDataAsynchronousFetchResult<T: NSFetchRequestResult> = ((NSAsynchronousFetchResult<T>) -> Void)?

extension NSManagedObject {
//    
//    @nonobjc
//    public class func coreFetchRequest<T>(expectedType: T.Type = T.self,_ entityName: String = "\(T.self)") -> NSFetchRequest<T> {
//        NSFetchRequest<T>(entityName: entityName)
//    }
//    
//    @nonobjc
//    public class func coreFetchAsyncRequest<T>(
//        _ request: NSFetchRequest<T>,
//        onCompletion: CoreDataAsynchronousFetchResult<T> = nil
//    ) -> NSAsynchronousFetchRequest<T> {
//        NSAsynchronousFetchRequest<T>.init(fetchRequest: request,completionBlock: onCompletion)
//    }
}

