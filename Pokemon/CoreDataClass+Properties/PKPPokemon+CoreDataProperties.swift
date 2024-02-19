//
//  PKPPokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//
//

import Foundation
import CoreData

extension PKPPokemon {
    
    @NSManaged public var color: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var name: String
    @NSManaged public var singlePhotoURL: String?
    @NSManaged public var url: String?
    @NSManaged public var relationship: Pokemonz?
}

extension PKPPokemon: Identifiable {
    
    static func nameFilterSortPredicate(_ query: String) -> (NSCompoundPredicate?, [NSSortDescriptor]?) {
        let caseInsensitiveNameKeyPath = \PKPPokemon.name
        guard !query.isEmpty else {
            let nameSortDescriptor = NSSortDescriptor(key: caseInsensitiveNameKeyPath._kvcKeyPathString!, ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
            return (nil,[nameSortDescriptor])
        }
        let caseInsensitiveNamePredicate = NSPredicate(format: "%K CONTAINS[c] %@", caseInsensitiveNameKeyPath._kvcKeyPathString!, query)
        let nameSortDescriptor = NSSortDescriptor(key: caseInsensitiveNameKeyPath._kvcKeyPathString!, ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [caseInsensitiveNamePredicate])
        return (compoundPredicate, [nameSortDescriptor])
    }

//    @nonobjc public class func fetchRequest() -> NSFetchRequest<PKPPokemon> {
//        return NSFetchRequest<PKPPokemon>(entityName: "PKPPokemon")
//    }
//    
//    @nonobjc public class func fetchRequestWithNameFilter(_ queryString: String) -> NSFetchRequest<PKPPokemon> {
//        let request = NSFetchRequest<PKPPokemon>(entityName: "PKPPokemon")
//        return request
//    }
//    
//    @nonobjc public class func fetchAsyncRequestWithNameAscending(_ queryString: String) -> NSAsynchronousFetchRequest<PKPPokemon> {
//        return NSAsynchronousFetchRequest<PKPPokemon>.init(fetchRequest: fetchRequestWithNameFilter(queryString))
//    }
//    
//    @nonobjc public class func fetchAsyncRequestWithNameAscending(_ request: NSFetchRequest<PKPPokemon>) -> NSAsynchronousFetchRequest<PKPPokemon> {
//        return NSAsynchronousFetchRequest<PKPPokemon>.init(fetchRequest: request)
//    }
//    
//    @nonobjc public class func fetchAsyncRequest() -> NSAsynchronousFetchRequest<PKPPokemon> {
//        return NSAsynchronousFetchRequest<PKPPokemon>.init(fetchRequest: fetchRequest())
//    }
//    
//    @nonobjc public class func fetchAsyncRequest(
//        _ request: NSFetchRequest<PKPPokemon>,
//        onCompletion: CoreDataAsynchronousFetchResult<PKPPokemon>
//    ) -> NSAsynchronousFetchRequest<PKPPokemon> {
//        return NSAsynchronousFetchRequest<PKPPokemon>.init(fetchRequest: request,completionBlock: onCompletion)
//    }
}


extension PKPPokemon: TableObject {
    
    var text: String? { name }
    var hashedID: String? { id == nil ? nil : "#\(id!)" }
}
