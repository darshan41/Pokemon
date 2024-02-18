//
//  Pokemon.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import PokemonAPI
import CoreData

@globalActor 
struct GlobaSharedResource {
    static let shared: Pokemon = .shared
}

actor Pokemon {
    
    let refresher: CoreDataRefresher = CoreDataRefresher()
    
    let currentCorePokemonDataStack: CoreDataStackManagible = CoreDataStack(model: .pokemon)
    
    nonisolated
    var viewContext: NSManagedObjectContext { currentCorePokemonDataStack.managedContext }
    
    nonisolated
    lazy var pokeDecoder: PokeDecoder = { CorePokeDecoder(with: viewContext) }()
    
    static let shared: Pokemon = Pokemon()
    
    private init() { }
}


class CoreDataRefresher {
    
    private let defaults: UserDefaults = .standard
    
    private func key(for service: ServicesCodingKeys) -> String {
        return "CoreDataRefresher." + service.rawValue
    }
    
    func shouldUpdateCoreData(for service: ServicesCodingKeys) -> Bool {
        guard let lastUpdatedDate = defaults.value(forKey: key(for: service)) as? Date else {
            return true
        }
        let twoDaysInSeconds: TimeInterval = 2 * 24 * 60 * 60
        let timeSinceLastUpdate = Date().timeIntervalSince(lastUpdatedDate)
        return timeSinceLastUpdate >= twoDaysInSeconds
    }
    
    func setLastUpdatedData(for service: ServicesCodingKeys) {
        defaults.setValue(Date(), forKey: key(for: service))
    }
    
    func removeLastUpdatedData(for service: ServicesCodingKeys) {
        defaults.setValue(nil, forKey: key(for: service))
    }
}
