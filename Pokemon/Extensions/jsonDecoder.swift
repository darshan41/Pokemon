//
//  jsonDecoder.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation
import CoreData

class PokeDecoder: JSONDecoder {
    
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}

class CorePokeDecoder: PokeDecoder {
    
    init(with context: NSManagedObjectContext) {
        super.init()
        userInfo[CodingUserInfoKey.managedObjectContext] = context
    }
}

extension JSONDecoder {
    
    func decoded<T: Codable>(_ data: Data) throws -> T {
        debugPrint("Got \(T.self), Decoding.....")
        return try decode(T.self, from: data)
    }
}
