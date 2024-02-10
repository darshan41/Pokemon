//
//  PokePedia.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

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
    
    class PokemonForm: Codable {
        let name: String
        let url: String
    }
    
    class PokemonMove: Codable {
        let name: String
        let url: String
    }
    
    /// Use  Legacy latest might be not set
    class PokemonCry: Codable {
        let latest: String
        /// Ogg URL
        let legacy: String
    }
    
    class GameIndices: Codable {
        let gameIndex: String
        let version: Version
    }
    
    class PokemonAbilityType: Codable {
        let slot: Int16
        let type: PokemonType
        
        struct PokemonType : Codable {
            let name: String
            let url: String
        }
    }
    
    class PokemonStat: Codable {
        
        class Stat: Codable {
            let name: String
            let url: String
        }
        
        let baseStat: Int16
        let effort: Int16
    }
}

