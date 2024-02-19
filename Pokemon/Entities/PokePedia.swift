//
//  PokePedia.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

/// Represents the PokePedia entity which stores information about a Pokemon.
class PokePedia: Codable {
    
    let id: Int16
    let name: String
    let order: Int16
    let isDefault: Bool
    let height: Int16
    let weight: Int16
    let baseExperience: Int16
    let abilities: [Ability]
    let cries: PokemonCry?
    let forms: [PokemonForm]
    let heldItems: [HeldItems]
//    let moves: [PokemonMove]?
//    let types: [PokemonAbilityType]
    let species: PokemonSpecie?
    let sprites: ExtendedPokemonSprite?
//    let stats: [PokemonStat]
//    let locationAreaEncounters: String
    //    let gameIndices: [GameIndices]?
//    let pastAbilities: [String]
//    let pastTypes: [String]
}


extension PokePedia {
    
    class Sprite: Codable {
        let backDefault: URL?
        let backFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
    }
    
    /// Represents a Pokemon form with name and URL.
    class PokemonForm: Codable {
        let name: String
        let url: String
    }
    
    /// Represents a Pokemon move with name and URL.
    class PokemonMove: Codable {
        let name: String?
        let url: String?
    }
    
    struct VersionGroupDetails: Codable {
        let levelLearnedAt: Int16
    }
    
    /// Represents the Pokemon cry with latest and legacy URLs.
    struct PokemonCry: Codable {
        let latest: String?
        /// Ogg URL
        let legacy: String?
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
