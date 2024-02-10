//
//  jsonDecoder.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

class PokeDecoder: JSONDecoder {
    
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
