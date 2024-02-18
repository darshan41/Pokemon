//
//  PokePedia.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

/// Represents the PokePedia entity which stores information about a Pokemon.
class PokePedia: Codable {
    
    let id: String
    let name: String
    let order: Int16
    let isDefault: Bool
    
    let abilities: [Ability]
    let slot: Int16
    
    let baseExperience: Int16
    let cries: PokemonCry?
    let forms: [PokemonForm]
    let height: Int16
    let weight: Int16
    
    let gameIndices: [GameIndices]?
    let heldItems: [HeldItems]
    
    let locationAreaEncounters: String
    
    let moves: [PokemonMove]
    let types: [PokemonAbilityType]
    let species: PokemonSpecie?
    let stats: [PokemonStat]
//    let pastAbilities: [String]
//    let pastTypes: [String]
}


extension PokePedia {
    
    /// Represents a Pokemon form with name and URL.
    class PokemonForm: Codable {
        let name: String
        let url: String
    }
    
    /// Represents a Pokemon move with name and URL.
    class PokemonMove: Codable {
        let name: String
        let url: String
    }
    
    /// Represents the Pokemon cry with latest and legacy URLs.
    class PokemonCry: Codable {
        let latest: String
        /// Ogg URL
        let legacy: String
    }
    
    /// Represents game indices with game index and version.
    class GameIndices: Codable {
        let gameIndex: String
        let version: Version
    }
    
    /// Represents a Pokemon ability type with slot and type information.
    class PokemonAbilityType: Codable {
        let slot: Int16
        let type: PokemonType
        
        /// Represents a Pokemon type with name and URL.
        struct PokemonType : Codable {
            let name: String
            let url: String
        }
    }
    
    /// Represents a Pokemon stat with base stat and effort.
    class PokemonStat: Codable {
        
        /// Represents a stat with name and URL.
        class Stat: Codable {
            let name: String
            let url: String
        }
        
        let baseStat: Int16
        let effort: Int16
    }
}
