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
public final class PKPPokemon: NSManagedObject,Decodable {
    
    enum CodingKeys: CodingKey {
        case color, id, name, singlePhotoURL, url
    }
    
    convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let hexColorCode = try? container.decodeIfPresent(String.self, forKey: .color),let color = UIColor.init(hex: hexColorCode)  {
            self.color = color
        } else {
            self.color = nil
        }
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.singlePhotoURL = try container.decodeIfPresent(String.self, forKey: .singlePhotoURL)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
