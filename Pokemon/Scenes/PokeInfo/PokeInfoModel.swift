//
//  PokeInfoModel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import Foundation

class PokeInfoModel {
    
    private let decoder: PokeDecoder = Pokemon.shared.pokeDecoder
    private let services: PokemonServices<PokePedia> = PokemonServices()
    
    private (set)var pokePedia: PokePedia?
    
    var onStateChange: (((MServiceState)) -> Void)?
    
    weak var pkpPokemon: PKPPokemon?
    
    init(pkpPokemon: PKPPokemon? = nil) {
        self.pkpPokemon = pkpPokemon
    }
    
    func getInformation() {
        onStateChange?(.loading)
        guard let pkpPokemon else {
            onStateChange?(.failure(APIManagerError.pokemonError(error: "Unable To Get Pokemon Meta PKPPokemon Data!")))
            return
        }
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            do{
                self.pokePedia = try await self.services.pokemonAPICalls(for: .pokemon, decoder: self.decoder, appendingPath: pkpPokemon.id ?? pkpPokemon.name)
                await MainActor.run {
                    self.onStateChange?(.success)
                }
            } catch {
                await MainActor.run {
                    self.onStateChange?(.failure(error.castedToAPIManagerError))
                }
            }
        }
    }
}



