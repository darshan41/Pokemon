//
//  PokemonVersions.swift
//  Pokemon
//
//  Created by Darshan S on 20/02/24.
//

import Foundation

struct PokemonVersions: Codable {
    let generationI: GenerationI
    let generationII: GenerationII
    let generationIII: GenerationIII
    let generationIV: GenerationIV
    let generationV: GenerationV
    let generationVI: GenerationVI
    let generationVII: GenerationVII
    let generationVIII: GenerationVIII
    
    struct GenerationI: Codable {
        let redBlue: VersionImages
        let yellow: VersionImages
    }
    
    struct GenerationII: Codable {
        let crystal: VersionImages
        let gold: VersionImages
        let silver: VersionImages
    }
    
    struct GenerationIII: Codable {
        let emerald: VersionImages
        let fireredLeafgreen: VersionImages
        let rubySapphire: VersionImages
    }
    
    struct GenerationIV: Codable {
        let diamondPearl: VersionImages
        let heartgoldSoulsilver: VersionImages
        let platinum: VersionImages
    }
    
    struct GenerationV: Codable {
        let blackWhite: VersionImages
    }
    
    struct GenerationVI: Codable {
        let omegarubyAlphasapphire: VersionImages
        let xY: VersionImages
    }
    
    struct GenerationVII: Codable {
        let icons: VersionImages
        let ultraSunUltraMoon: VersionImages
    }
    
    struct GenerationVIII: Codable {
        let icons: VersionImages
    }
    
    struct VersionImages: Codable {
        let backDefault: String
        let backGray: String?
        let backTransparent: String?
        let backShiny: String?
        let backShinyTransparent: String?
        let frontDefault: String
        let frontGray: String?
        let frontTransparent: String?
        let frontShiny: String?
        let frontShinyTransparent: String?
        let animated: AnimatedImages?
        
        struct AnimatedImages: Codable {
            let backDefault: String
            let backFemale: String?
            let backShiny: String
            let backShinyFemale: String?
            let frontDefault: String
            let frontFemale: String?
            let frontShiny: String
            let frontShinyFemale: String?
        }
    }
}

