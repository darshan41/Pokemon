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
    
    private let decoder: PokeDecoder = CorePokeDecoder(with: Pokemon.shared.viewContext)
    private var pokecallz: Pokemonz?
    
    func getEndPoints() {
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            do {
                let services = try await PokemonServices<Services>().pokemonAPICalls(for: .service, decoder: decoder)
                await MainActor.run {
                    Constants.API.services = services
                }
                if Pokemon.shared.refresher.shouldUpdateCoreData(for: .service) {
                    let pokecallz = try await PokemonServices<Pokemonz>().pokemonAPICalls(handler: PackedParam(for: .pokemon,decoder: self.decoder,parameters: [
                        .limit: "9999"
                    ]))
                    self.pokecallz = pokecallz
                    try await MainActor.run {
                        try Pokemon.shared.currentCorePokemonDataStack.saveContext()
                        Pokemon.shared.refresher.setLastUpdatedData(for: .service)
                        self.presenter?.onSuccess()
                    }
                } else {
                    await MainActor.run {
                        self.presenter?.onSuccess()
                    }
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
    
    typealias T = PKPPokemon
    
    func findObjects(_ queryString: String) async -> [T] {
        do {
            let request = PKPPokemon.coreFetchRequest(expectedType: PKPPokemon.self)
            let descrtiptors = PKPPokemon.nameFilterSortPredicate(queryString)
            request.predicate = descrtiptors.0
            request.sortDescriptors = descrtiptors.1
            let pokemons = try await PKPPokemon.coreFetchAsyncRequest(request, in: Pokemon.shared.viewContext)
            return pokemons
        } catch {
            return []
        }
    }
    
    func findObjects(
        _ queryString: String,
        onCompletion: @escaping (([PKPPokemon]) -> Void)
    ) {
        let request = PKPPokemon.coreFetchRequest(expectedType: PKPPokemon.self)
        let descrtiptors = PKPPokemon.nameFilterSortPredicate(queryString)
        request.predicate = descrtiptors.0
        request.sortDescriptors = descrtiptors.1
        let newAsyncRequest = PKPPokemon.coreFetchAsyncRequest(request) { result in
            if let pokemons = result.finalResult {
                onCompletion(pokemons)
            } else {
                onCompletion([])
            }
        }
        do {
            try Pokemon.shared.viewContext.execute(newAsyncRequest)
        } catch {
            onCompletion([])
        }
    }
}

// MARK: Input for Interactor Protocol

extension SplashInteractor: SplashInteractorInputProtocol { }
