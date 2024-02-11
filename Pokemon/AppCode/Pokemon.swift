//
//  Pokemon.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import PokemonAPI

final class Pokemon {
    
    let pokemonAPI: PokemonAPI = PokemonAPI()
    
    private lazy var currentCoreDataContext: CoreDataStackManagible = {
        CoreDataStack(model: .pokemon)
    }()
    
    static let shared: Pokemon = Pokemon()
    
    private init() { }
}
