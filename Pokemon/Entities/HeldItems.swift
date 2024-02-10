//
//  HeldItems.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

struct HeldItems: Codable {
    let item: Item
    let versionDetails: [VersionDetails]
}

extension HeldItems {
    
    struct Item: Codable {
        let name: String
        let url: String
    }
    
    struct VersionDetails: Codable {
        let rarity: Int
        let version: Version
    }
}

