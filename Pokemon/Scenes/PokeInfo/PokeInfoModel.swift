//
//  PokeInfoModel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import Foundation

class PokeInfoModel {

    private let decoder: PokeDecoder = Pokemon.shared.pokeDecoder
    
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
    }
}
