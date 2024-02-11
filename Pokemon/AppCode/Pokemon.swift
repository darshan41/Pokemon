//
//  Pokemon.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import PokemonAPI
import CoreData

final class Pokemon {
    
    let pokemonAPI: PokemonAPI = PokemonAPI()
    
    let currentCorePokemonDataStack: CoreDataStackManagible = CoreDataStack(model: .pokemon)
    
    var viewContext: NSManagedObjectContext { currentCorePokemonDataStack.managedContext }
    
    static let shared: Pokemon = Pokemon()
    
    private init() { }
}

