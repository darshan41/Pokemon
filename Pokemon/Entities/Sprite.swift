//
//  Sprite.swift
//  Pokemon
//
//  Created by Darshan S on 19/02/24.
//

import Foundation

class PokemonSprite: Codable {
    let backDefault: URL?
    let backFemale: URL?
    let backShiny: URL?
    let backShinyFemale: URL?
    let frontDefault: URL?
    let frontFemale: URL?
    let frontShiny: URL?
    let frontShinyFemale: URL?
}

class ExtendedPokemonSprite: PokemonSprite {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case other
        //        case versions
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        other = try container.decodeIfPresent(OtherSprites.self, forKey: .other)
        //        versions = try container.decodeIfPresent(PokemonVersions.self, forKey: .versions)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(other, forKey: .other)
        //        try container.encode(versions, forKey: .versions)
        try super.encode(to: encoder)
    }
    
    let other: OtherSprites?
    //    let versions: PokemonVersions?
}
class OtherSprites: Codable {
    let dreamWorld: PokemonSprite?
    let home: PokemonSprite?
    let officialArtwork: PokemonSprite?
    let showdown: PokemonSprite?
}

struct DreamWorldSprites: Codable {
    let frontDefault: URL?
    let frontFemale: URL?
}

struct HomeSprites: Codable {
    let frontDefault: URL?
    let frontFemale: URL?
    let frontShiny: URL?
    let frontShinyFemale: URL?
}

struct OfficialArtworkSprites: Codable {
    let frontDefault: URL?
    let frontShiny: URL?
}

struct ShowdownSprites: Codable {
    let backDefault: URL?
    let backFemale: URL?
    let backShiny: URL?
    let backShinyFemale: URL?
    let frontDefault: URL?
    let frontFemale: URL?
    let frontShiny: URL?
    let frontShinyFemale: URL?
}




extension ExtendedPokemonSprite {
    
    enum ImageFormat: String,Codable {
        case gif = "gif"
        case png = "png"
        case svg = "svg"
    }
    
    struct ImageLoadHelper: Codable {
        let format: ExtendedPokemonSprite.ImageFormat
        let url: URL
    }
    
    var frontLoadImage: ImageLoadHelper? {
        if let frontHomeDefaultPng = self.other?.home?.frontDefault,let format = frontHomeDefaultPng.format {
            return ImageLoadHelper(format: format, url: frontHomeDefaultPng)
        } else if let frontOfficialDefaultPng = self.other?.home?.frontDefault,let format = frontOfficialDefaultPng.format {
            return ImageLoadHelper(format: format, url: frontOfficialDefaultPng)
        } else if let frontDefaultSVG = self.other?.dreamWorld?.frontDefault,let format = frontDefaultSVG.format  {
            return ImageLoadHelper(format: format, url: frontDefaultSVG)
        }
        return nil
    }
    
    var frontLoadPreferSVGImage: ImageLoadHelper? {
        if let frontDefaultSVG = self.other?.dreamWorld?.frontDefault,let format = frontDefaultSVG.format {
            return ImageLoadHelper(format: format, url: frontDefaultSVG)
        } else if let frontHomeDefaultPng = self.other?.home?.frontDefault,let format = frontHomeDefaultPng.format {
            return ImageLoadHelper(format: format, url: frontHomeDefaultPng)
        } else if let frontOfficialDefaultPng = self.other?.home?.frontDefault,let format = frontOfficialDefaultPng.format  {
            return ImageLoadHelper(format: format, url: frontOfficialDefaultPng)
        }
        return nil
    }
}

fileprivate extension URL? {
    
    var format: ExtendedPokemonSprite.ImageFormat? {
        ExtendedPokemonSprite.ImageFormat.init(optRawValue: self?.pathExtension)
    }
}


fileprivate extension URL {
    
    var format: ExtendedPokemonSprite.ImageFormat? {
        ExtendedPokemonSprite.ImageFormat.init(optRawValue: self.pathExtension)
    }
}
