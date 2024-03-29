//
//  Ability.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

class Ability: Codable {
    
    let ability: Info
    let isHidden: Bool
    let slot: Bool
    
}

extension Ability {
    
    class Info: Codable {
        let name: String
        let url: String
    }
}
