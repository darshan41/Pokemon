//
//  PokemonServices.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

actor PokemonServices<SomeModel: Codable> {
    
    private let shared = APIManager.shared
    
    var urlSession: URLSession?
    var supplementartURLRequest: URLRequest?
    var headers: BasicDict?
    
    lazy private var decoder: PokeDecoder = { PokeDecoder() }()
    
}

extension PokemonServices  {
    
    // MARK: EndPoints from static Struct EndPoints.
    
    // MARK: URL Can be customised by static Endpoint Methods which can be linked to coding keys
    
    // MARK: Linked by Customised static EndPoints which are dependent on Coding Keys -> (url/customisedURL,Service Type eg, .Get,.Post...)
    
    // MARK: Expected Parameter Type (Expected data - Must be Codable)
    
    func pokemonAPICalls(
        for service: ServicesCodingKeys,
        decoder: PokeDecoder? = nil,
        _ urlReplacingIdentifiers: BasicDict? = nil,
        _ parameters: BasicDict? = nil
    ) async throws -> SomeModel {
        guard let serviceInfo = try Services.getCustomisedEndPoints(for: service, urlReplacingIdentifiers) else {
            throw APIManagerError.invalidServiceInformation(key: service)
        }
        let parameters = serviceInfo.addDefaultParamsWhereverNeccesary(with: parameters)
        let url = try ServiceInfo.serviceRequirementChecker(
            with: serviceInfo,
            parameters: parameters,
            replacingIdentifiers: urlReplacingIdentifiers,
            headers: self.headers
        )
        let httpMethod = serviceInfo.serviceMethod ?? .Get
        print("👻",url.absoluteString)
        let data = try await shared.request(
            url,
            httpMethod,
            httpMethod == .Get ? nil : try parameters?.serialize(),
            headers,
            urlSession,
            supplementartURLRequest
        )
        if let decoder {
            return try decoder.decoded(data)
        } else {
            return try self.decoder.decoded(data)
        }
    }
    
    func pokemonAPICalls(
        handler paramHandler: PackedParam
    ) async throws -> SomeModel {
        self.urlSession = paramHandler.session
        self.supplementartURLRequest = paramHandler.supplementartURLRequest
        return try await self.pokemonAPICalls(
            for: paramHandler.key,
            paramHandler.urlReplacingIdentifiers?.toParamDictionary,
            paramHandler.parameters?.toParamDictionary
        )
    }
}

extension PokemonServices {
    
}
