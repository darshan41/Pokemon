//
//  PokemonAPIEnvironment.swift
//  Pokemon
//
//  Created by Darshan S on 09/02/24.
//

import Foundation
import PokemonAPI
import CoreData

class PokemonAPIEnvironment: ObservableObject {
    
    let pokemonAPI: PokemonAPI
    private static let kLimit: Int = 9999
    
    @Published var pagedObject: PKMPagedObject<PKMPokemon>?
    @Published var error: Error?
    
    init(pokemonAPI: PokemonAPI) {
        self.pokemonAPI = pokemonAPI
    }
    
    func fetchPokemon(paginationState: PaginationState<PKMPokemon> = .initial(pageLimit: kLimit)) async {
        do {
            let fetchedObject = try await pokemonAPI.pokemonService.fetchPokemonList(paginationState: paginationState)
            DispatchQueue.main.async {
                self.pagedObject = fetchedObject
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
}

