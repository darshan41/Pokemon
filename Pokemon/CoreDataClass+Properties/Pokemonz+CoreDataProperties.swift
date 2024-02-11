//
//  Pokemonz+CoreDataProperties.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//
//

import Foundation
import CoreData

extension Pokemonz {

    @NSManaged public var results: NSOrderedSet?

}

// MARK: Generated accessors for results
extension Pokemonz {

    @objc(insertObject:inResultsAtIndex:)
    @NSManaged public func insertIntoResults(_ value: PKPPokemon, at idx: Int)

    @objc(removeObjectFromResultsAtIndex:)
    @NSManaged public func removeFromResults(at idx: Int)

    @objc(insertResults:atIndexes:)
    @NSManaged public func insertIntoResults(_ values: [PKPPokemon], at indexes: NSIndexSet)

    @objc(removeResultsAtIndexes:)
    @NSManaged public func removeFromResults(at indexes: NSIndexSet)

    @objc(replaceObjectInResultsAtIndex:withObject:)
    @NSManaged public func replaceResults(at idx: Int, with value: PKPPokemon)

    @objc(replaceResultsAtIndexes:withResults:)
    @NSManaged public func replaceResults(at indexes: NSIndexSet, with values: [PKPPokemon])

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: PKPPokemon)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: PKPPokemon)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSOrderedSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSOrderedSet)

}

extension Pokemonz : Identifiable {

}
