//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

extension Bool: Describable { }
extension Int: Describable { }
extension Double: Describable { }
extension String: Describable { }
extension Array: Describable { }

protocol SingleParamProtocol {
    var key: ServicesCodingKeys { get }
    var parameters: BasicDict? { get }
    var headers: BasicDict? { get }
    var urlReplacingIdentifiers: BasicDict? { get }
    var session: URLSession? { get }
    var supplementartURLRequest: URLRequest? { get }
}

struct PackedParam  {
    
    let decoder: PokeDecoder
    let key: ServicesCodingKeys

    var appendingPath: String?
    var parameters: ParameterDictionary?
    var urlReplacingIdentifiers: ParameterDictionary?
    var headers: BasicDict?
    var session: URLSession?
    var supplementartURLRequest: URLRequest?
    
    
    init(
        for key: ServicesCodingKeys,
        decoder: PokeDecoder,
        parameters: ParameterDictionary? = nil,
        headers: BasicDict? = nil,
        urlReplacingIdentifiers: ParameterDictionary? = nil
    ) {
        self.decoder = decoder
        self.key = key
        self.parameters = parameters
        self.headers = headers
        self.urlReplacingIdentifiers = urlReplacingIdentifiers
    }
}
