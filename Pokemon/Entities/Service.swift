//
//  Service.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation

struct Services: Codable,ValueCheckable {
    
    let service: String?
    let ability: String?
    let berry: String?
    let berryFirmness: String?
    let berryFlavor: String?
    let characteristic: String?
    let contestEffect: String?
    let contestType: String?
    let eggGroup: String?
    let encounterCondition: String?
    let encounterConditionValue: String?
    let encounterMethod: String?
    let evolutionChain: String?
    let evolutionTrigger: String?
    let gender: String?
    let generation: String?
    let language: String?
    let location: String?
    let machine: String?
    let move: String?
    let pokedex: String?
    let pokemon: String?
    let item: String?
    let version: String?
    let nature: String?
    let region: String?
    let stat: String?
    let growthRate: String?
    let itemAttribute: String?
    let itemCategory: String?
    let moveTarget: String?
    let itemPocket: String?
    let pokemonColor: String?
    let pokemonForm: String?
    let pokemonHabitat: String?
    let pokemonShape: String?
    let pokemonSpecies: String?
    let type: String?
    let moveBattleStyle: String?
    let itemFlingEffect: String?
    let moveDamageClass: String?
    let moveLearnMethod: String?
    let palParkArea: String?
    let superContestEffect: String?
    let locationArea: String?
    let moveCategory: String?
    let moveAilment: String?
    let pokeathlonStat: String?
    let versionGroup: String?
    
    enum ServiceCodingKey: String,CaseIterable,CodingKey {
        case ability = "ability"
        case berry = "berry"
        case berryFirmness = "berry-firmness"
        case berryFlavor = "berry-flavor"
        case characteristic = "characteristic"
        case contestEffect = "contest-effect"
        case contestType = "contest-type"
        case eggGroup = "egg-group"
        case encounterCondition = "encounter-condition"
        case encounterConditionValue = "encounter-condition-value"
        case encounterMethod = "encounter-method"
        case evolutionChain = "evolution-chain"
        case evolutionTrigger = "evolution-trigger"
        case gender = "gender"
        case generation = "generation"
        case language = "language"
        case location = "location"
        case machine = "machine"
        case move = "move"
        case pokedex = "pokedex"
        case pokemon = "pokemon"
        case item = "item"
        case service = "service"
        case version = "version"
        case nature = "nature"
        case region = "region"
        case stat = "stat"
        case growthRate = "growth-rate"
        case itemAttribute = "item-attribute"
        case itemCategory = "item-category"
        case moveTarget = "move-target"
        case itemPocket = "item-pocket"
        case pokemonColor = "pokemon-color"
        case pokemonForm = "pokemon-form"
        case pokemonHabitat = "pokemon-habitat"
        case pokemonShape = "pokemon-shape"
        case pokemonSpecies = "pokemon-species"
        case type = "type"
        case moveBattleStyle =  "move-battle-style"
        case itemFlingEffect =  "item-fling-effect"
        case moveDamageClass =  "move-damage-class"
        case moveLearnMethod =  "move-learn-method"
        case palParkArea =  "pal-park-area"
        case superContestEffect =  "super-contest-effect"
        case locationArea = "location-area"
        case moveCategory = "move-category"
        case moveAilment = "move-ailment"
        case pokeathlonStat = "pokeathlon-stat"
        case versionGroup = "version-group"
    }
}

extension Services {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ServiceCodingKey.self)
        self.ability = try container.decodeIfPresent(String.self, forKey: .ability)
        self.berry = try container.decodeIfPresent(String.self, forKey: .berry)
        self.berryFirmness = try container.decodeIfPresent(String.self, forKey: .berryFirmness)
        self.berryFlavor = try container.decodeIfPresent(String.self, forKey: .berryFlavor)
        self.characteristic = try container.decodeIfPresent(String.self, forKey: .characteristic)
        self.contestEffect = try container.decodeIfPresent(String.self, forKey: .contestEffect)
        self.contestType = try container.decodeIfPresent(String.self, forKey: .contestType)
        self.eggGroup = try container.decodeIfPresent(String.self, forKey: .eggGroup)
        self.encounterCondition = try container.decodeIfPresent(String.self, forKey: .encounterCondition)
        self.encounterConditionValue = try container.decodeIfPresent(String.self, forKey: .encounterConditionValue)
        self.encounterMethod = try container.decodeIfPresent(String.self, forKey: .encounterMethod)
        self.evolutionChain = try container.decodeIfPresent(String.self, forKey: .evolutionChain)
        self.evolutionTrigger = try container.decodeIfPresent(String.self, forKey: .evolutionTrigger)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.generation = try container.decodeIfPresent(String.self, forKey: .generation)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.machine = try container.decodeIfPresent(String.self, forKey: .machine)
        self.move = try container.decodeIfPresent(String.self, forKey: .move)
        self.pokedex = try container.decodeIfPresent(String.self, forKey: .pokedex)
        self.pokemon = try container.decodeIfPresent(String.self, forKey: .pokemon)
        self.item = try container.decodeIfPresent(String.self, forKey: .item)
        self.service = try container.decodeIfPresent(String.self, forKey: .service)
        self.version = try container.decodeIfPresent(String.self, forKey: .version)
        self.nature = try container.decodeIfPresent(String.self, forKey: .nature)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.stat = try container.decodeIfPresent(String.self, forKey: .stat)
        self.growthRate = try container.decodeIfPresent(String.self, forKey: .growthRate)
        self.itemAttribute = try container.decodeIfPresent(String.self, forKey: .itemAttribute)
        self.itemCategory = try container.decodeIfPresent(String.self, forKey: .itemCategory)
        self.moveTarget = try container.decodeIfPresent(String.self, forKey: .moveTarget)
        self.itemPocket = try container.decodeIfPresent(String.self, forKey: .itemPocket)
        self.pokemonColor = try container.decodeIfPresent(String.self, forKey: .pokemonColor)
        self.pokemonForm = try container.decodeIfPresent(String.self, forKey: .pokemonForm)
        self.pokemonHabitat = try container.decodeIfPresent(String.self, forKey: .pokemonHabitat)
        self.pokemonShape = try container.decodeIfPresent(String.self, forKey: .pokemonShape)
        self.pokemonSpecies = try container.decodeIfPresent(String.self, forKey: .pokemonSpecies)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.moveBattleStyle = try container.decodeIfPresent(String.self, forKey: .moveBattleStyle)
        self.itemFlingEffect = try container.decodeIfPresent(String.self, forKey: .itemFlingEffect)
        self.moveDamageClass = try container.decodeIfPresent(String.self, forKey: .moveDamageClass)
        self.moveLearnMethod = try container.decodeIfPresent(String.self, forKey: .moveLearnMethod)
        self.palParkArea = try container.decodeIfPresent(String.self, forKey: .palParkArea)
        self.superContestEffect = try container.decodeIfPresent(String.self, forKey: .superContestEffect)
        self.locationArea = try container.decodeIfPresent(String.self, forKey: .locationArea)
        self.moveCategory = try container.decodeIfPresent(String.self, forKey: .moveCategory)
        self.moveAilment = try container.decodeIfPresent(String.self, forKey: .moveAilment)
        self.pokeathlonStat = try container.decodeIfPresent(String.self, forKey: .pokeathlonStat)
        self.versionGroup = try container.decodeIfPresent(String.self, forKey: .versionGroup)
    }
}

extension Services {
    
    static func getCustomisedEndPoints(
        for key: ServicesCodingKeys,
        _ replacingIdentifiers: BasicDict? = nil
    ) throws -> ServiceInfo? {
        return try Self.getDefaultCustomisedEndPoints(
            for: key,
            replacingIdentifiers
        )
    }
    
#warning("Change this as per your requirement add more values.....")
    static func getDefaultCustomisedEndPoints(
        for key: ServicesCodingKeys,
        _ replacingIdentifiers: BasicDict? = nil
    ) throws -> ServiceInfo? {
        if key == .service {
            return ServiceInfo(serviceKey: .service, serviceURL: Constants.API.serviceEndPoint, serviceMethod: .Get)
        }
        switch key {
        case .pokemon:
            return ServiceInfo(
                serviceKey: .pokemon,
                serviceURL: Constants.API.services?.pokemon,
                serviceMethod: .Get
            )
        default:
            return nil
        }
    }
}
