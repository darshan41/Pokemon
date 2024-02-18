//
//  SplashModel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import Foundation

class SplashModel {
    
    private let decoder: PokeDecoder = Pokemon.shared.pokeDecoder
    
    var onStateChange: (((MServiceState)) -> Void)?
    
}

extension SplashModel {
    
    func getEndPoints() {
        assert(Thread.isMainThread)
        onStateChange?(.loading)
        Task.detached(priority: .background) { @MainActor [weak self] in
            guard let self else { return }
            do {
                if let services = UserDefaultValues.services, !Pokemon.shared.refresher.shouldUpdateCoreData(for: .service) {
                    Constants.API.services = services
                    self.onStateChange?(.success)
                } else {
                    let services = try await PokemonServices<Services>().pokemonAPICalls(for: .service, decoder: self.decoder)
                    Constants.API.services = services
                    UserDefaultValues.services = services
                    Pokemon.shared.refresher.setLastUpdatedData(for: .service)
                    self.onStateChange?(.success)
                }
            } catch {
                UserDefaultValues.services = nil
                await MainActor.run {
                    self.onStateChange?(.failure(error.castedToAPIManagerError))
                }
            }
        }
    }
}
