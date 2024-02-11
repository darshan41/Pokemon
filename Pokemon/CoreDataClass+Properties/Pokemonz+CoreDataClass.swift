//
//  Pokemonz+CoreDataClass.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//
//

import Foundation
import CoreData

@objc(Pokemonz)
public final class Pokemonz: NSManagedObject,Codable {
    
    enum CodingKeys: CodingKey {
        case results
    }
    
    convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let results = try? container.decode([PKPPokemon].self, forKey: .results) {
            print("👻",results)
            self.results = nil
            self.results = NSOrderedSet(array: results)
        } else {
            self.results = []
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let resultsArray = results?.array as? [PKPPokemon] {
            try container.encode(resultsArray, forKey: .results)
        }
    }
}
