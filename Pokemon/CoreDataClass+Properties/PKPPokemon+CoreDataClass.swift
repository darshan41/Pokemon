//
//  PKPPokemon+CoreDataClass.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//
//

import Foundation
import CoreData
import UIKit

enum DecoderConfigurationError: ErrorShowable {
  case missingManagedObjectContext
    
    var showableDescription: String {
        switch self {
        case .missingManagedObjectContext:
            return "No Managed object context has been found in order to decode!"
        }
    }
}

@objc(PKPPokemon)
public final class PKPPokemon: NSManagedObject,Codable {
    
    enum CodingKeys: CodingKey {
        case color, id, name, singlePhotoURL, url
    }
    
    convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        assert(context == Pokemon.shared.viewContext)
        assert(Pokemon.shared.currentCorePokemonDataStack.managedContext == Pokemon.shared.viewContext)
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let hexColorCode = try? container.decodeIfPresent(String.self, forKey: .color),let color = UIColor.init(hex: hexColorCode)  {
            self.color = color
        } else {
            self.color = nil
        }
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.name = try container.decode(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        } else {
            self.id = url.extractedPokemonID
        }
        self.singlePhotoURL = try container.decodeIfPresent(String.self, forKey: .singlePhotoURL)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.singlePhotoURL, forKey: .singlePhotoURL)
        try container.encodeIfPresent(self.url, forKey: .url)
        if let color = self.color,let hexColorCode = (color as? UIColor)?.toHexString() {
            try container.encodeIfPresent(hexColorCode, forKey: .color)
        }
    }
}

extension String? {
    
    var extractedPokemonID: String? {
        guard let url = self.asURL else { return nil }
        let pathComponents = url.pathComponents
        guard let lastComponent = pathComponents.last, pathComponents.count >= 2,let intId = Int(lastComponent) else { return nil }
        return String(intId)
    }
}
