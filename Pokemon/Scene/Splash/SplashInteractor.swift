//
//  Splashinteractor.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import SwiftUI
import PokemonAPI

class SplashInteractor  {
    
    weak var presenter: SplashInteractorOutputProtocol?
    
    private let decoder: PokeDecoder = CorePokeDecoder(with: Pokemon.shared.currentCoreDataContext.managedContext)
    
    var pokemons: [Pokemonz] = []
    
    func getEndPoints() {
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            do {
                let services = try await PokemonServices<Services>().pokemonAPICalls(for: .service)
                await MainActor.run {
                    Constants.API.services = services
                }
                let pokecallz = try await PokemonServices<Pokecallz>().pokemonAPICalls(handler: PackedParam(for: .pokemon, parameters: [.limit: "9999"]))
                await MainActor.run {
                    self.pokemons = pokecallz.results
                    self.presenter?.onSuccess()
                }
            } catch {
                await MainActor.run {
                    self.presenter?.onFailure(with: error.castedToAPIManagerError)
                }
            }
        }
    }
}

// MARK: TableObservableObject

extension SplashInteractor: TableObservableObject {
    
    typealias T = Pokemonz
    
    func findObjects(_ queryString: String) -> [T] {
        let lowercaseQuery = queryString.lowercased()
        guard !queryString.isEmpty else { return pokemons }
        let filtered = pokemons.filter { pokemon in
            guard let text = pokemon.text?.lowercased() else {
                return false
            }
            return text.localizedCaseInsensitiveContains(lowercaseQuery)
        }
        return filtered
    }
}

// MARK: Input for Interactor Protocol

extension SplashInteractor: SplashInteractorInputProtocol { }

struct Pokecallz: Codable {
    let count: Int16
    let next: String?
    let previous: String?
    let results: [Pokemonz]
}

struct Pokemonz: Codable,TableObject {
    var text: String? { name }
    var id: String { url }
    
    let name: String
    let url: String
}
