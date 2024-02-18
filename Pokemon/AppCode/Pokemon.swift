//
//  Pokemon.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation
import PokemonAPI
import CoreData

/// Manages the Pokemon actor responsible for handling Pokemon data and CoreData operations.
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


/// Manages the refreshing of CoreData for different services.
class CoreDataRefresher {
    
    private let defaults: UserDefaults = .standard
    
    private func key(for service: ServicesCodingKeys) -> String {
        return "CoreDataRefresher." + service.rawValue
    }
    
    /// Checks if CoreData needs to be updated for a specific service based on the last update date.
    /// - Parameter service: The service for which CoreData update needs to be checked.
    /// - Returns: A boolean value indicating whether CoreData needs to be updated.
    func shouldUpdateCoreData(for service: ServicesCodingKeys) -> Bool {
        guard let lastUpdatedDate = defaults.value(forKey: key(for: service)) as? Date else {
            return true
        }
        let twoDaysInSeconds: TimeInterval = 2 * 24 * 60 * 60
        let timeSinceLastUpdate = Date().timeIntervalSince(lastUpdatedDate)
        return timeSinceLastUpdate >= twoDaysInSeconds
    }
    
    /// Sets the last updated date for a specific service in UserDefaults.
    /// - Parameter service: The service for which the last updated date needs to be set.
    func setLastUpdatedData(for service: ServicesCodingKeys) {
        defaults.setValue(Date(), forKey: key(for: service))
    }
    
    /// Removes the last updated date for a specific service from UserDefaults.
    /// - Parameter service: The service for which the last updated date needs to be removed.
    func removeLastUpdatedData(for service: ServicesCodingKeys) {
        defaults.setValue(nil, forKey: key(for: service))
    }
}
