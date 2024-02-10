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
    
}

extension PokemonServices  {
    
    // MARK: EndPoints from static Struct EndPoints.
    
    // MARK: URL Can be customised by static Endpoint Methods which can be linked to coding keys
    
    // MARK: Linked by Customised static EndPoints which are dependent on Coding Keys -> (url/customisedURL,Service Type eg, .Get,.Post...)
    
    // MARK: Expected Parameter Type (Expected data - Must be Codable)
    
    func pokemonAPICalls(
        for service: ServicesCodingKeys,
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
        switch httpMethod {
        case .Get:
            return try await shared.request(
                url,
                expectingReturnType: SomeModel.self,
                httpMethod,
                nil,
                headers,
                urlSession,
                supplementartURLRequest
            )
        case .Post,.Delete,.Put:
            return try await shared.request(
                url,
                expectingReturnType: SomeModel.self,
                httpMethod,
                try parameters?.serialize(),
                headers,
                urlSession,
                supplementartURLRequest
            )
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
