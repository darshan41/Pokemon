//
//  SplashModel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import Foundation

class SplashModel {
    
    enum ServiceState {
        case loading
        case success
        case failure(ErrorShowable)
    }
    
    private let decoder: PokeDecoder = Pokemon.shared.pokeDecoder
    
    var onStateChange: (((ServiceState)) -> Void)?
    
}

extension SplashModel {
    
    func getEndPoints() {
        assert(Thread.isMainThread)
        onStateChange?(.loading)
        Task.detached(priority: .background) { @MainActor [weak self] in
            guard let self else { return }
            do {
                let services = try await PokemonServices<Services>().pokemonAPICalls(for: .service, decoder: self.decoder)
                Constants.API.services = services
                self.onStateChange?(.success)
            } catch {
                await MainActor.run {
                    self.onStateChange?(.failure(error.castedToAPIManagerError))
                }
            }
        }
    }
}
