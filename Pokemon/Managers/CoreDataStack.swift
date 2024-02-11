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
    
    func saveContext() -> CoreDataStack.Error?
    
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
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = { self.storeContainer.viewContext }()
    
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

    @discardableResult
    func saveContext() -> CoreDataStack.Error? {
        let context = managedContext
        guard context.hasChanges else {
            if ignoreCoreDataNoChangeError {
                return nil
            }
            return Error.noChanges
        }
        do {
            try context.save()
            return nil
        } catch {
            return Error.custom(error.localizedDescription)
        }
    }
}

// MARK: Helper func's

private extension CoreDataStack {

    @objc func saveChanges() {
        if UIApplication.shared.applicationState == .background {
            guard savesChangesOnAppBackground else { return }
            saveContext()
        } else {
            saveContext()
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
