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
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PKPPokemon> {
        return NSFetchRequest<PKPPokemon>(entityName: "PKPPokemon")
    }
    
    @NSManaged public var color: NSObject?
    @NSManaged public var id: String?
    @NSManaged public var name: String
    @NSManaged public var singlePhotoURL: String?
    @NSManaged public var url: String?
    
}

extension PKPPokemon : Identifiable {
    
}
