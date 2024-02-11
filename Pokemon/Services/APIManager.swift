//
//  APIManager.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

typealias PokemonResult<SomeModel: Codable> = (Result<SomeModel,APIManagerError>) -> Void
typealias APIManagerAsyncData = (data: Data,response: URLResponse)
typealias Serviceable<T: Codable> = T
typealias pokemonResult = Codable & ErrorCheckable


// MARK: Rather than class expose Protocols

protocol APIManagerProtocol {
    
    var session: URLSession { get }
    
    func request(
        _ url: URL,
        _ httpMethod: ServiceMethod,
        _ body: Data?,
        _ headers: BasicDict?,
        _ urlSession: URLSession?,
        _ supplementaryURLRequest: URLRequest?
    ) async throws -> Data
}

// MARK: cannot be inherited

final class APIManager {
    
    private let decoder: PokeDecoder = PokeDecoder()
    
    // MARK: No initilisers for main service handlers.
    
    public internal(set) var session: URLSession = .shared
    
    static let shared: APIManagerProtocol = APIManager()
    
    private init() {
        session.configuration.timeoutIntervalForRequest = 30
    }
}

// MARK: APICallerProtocol

extension APIManager: APIManagerProtocol {
    
    /// will override the URL Property
    func request(
        _ url: URL,
        _ httpMethod: ServiceMethod,
        _ body: Data?,
        _ headers: BasicDict?,
        _ urlSession: URLSession? = nil,
        _ supplementaryURLRequest: URLRequest? = nil
    ) async throws -> Data {
        let session = urlSession ?? session
        var request = supplementaryURLRequest ?? URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            request.httpBody = body
        }
        request.addHeaders(from: headers)
        do {
            return try await responseHandler(session.data(for: request, delegate: nil))
        } catch let error {
            try error.codeChecker()
            throw APIManagerError.somethingWentWrong
        }
    }
}


// MARK: Helper func's

extension HTTPURLResponse {
    
    func statusCodeChecker() throws {
        switch self.statusCode {
        case 200...299:
            return
        case 500...599:
            throw APIManagerError.internalServerError
        default:
            throw NSURLErrors.init(rawValue: statusCode)?.showableError ?? APIManagerError.somethingWentWrong
        }
    }
}

extension APIManager {
    
    func responseHandler(_ asyncResponsiveData: APIManagerAsyncData) async throws -> Data {
        guard let response = asyncResponsiveData.response as? HTTPURLResponse else {
            throw APIManagerError.conversionFailedToHTTPURLResponse
        }
        return asyncResponsiveData.data
//        return try await decode(data: asyncResponsiveData.data,resposne: response)
    }
    
}

// MARK: ErrorWithCode XTension

extension BasicDict {
    
    @discardableResult
    func returnError(with errorCode: Int) throws -> Int {
        guard let pickedError = self.first(where: { "\($0.key)" == "\(errorCode)" }) else {
            return errorCode
        }
        throw APIManagerError.errorWithCode(
            errorCode: pickedError.key,
            errorString: pickedError.value
        )
    }
}

// MARK: - Helper func's

extension Error {
    
    var statusCode: Int { (self as NSError).code }
    
    func codeChecker() throws {
        switch self.statusCode {
        case 200...299:
            return
        case 500...599:
            throw APIManagerError.internalServerError
        default:
            throw NSURLErrors.init(rawValue: statusCode)?.showableError ?? APIManagerError.somethingWentWrong
        }
    }
    
    var castedToAPIManagerError: APIManagerError {
        (self as? APIManagerError) ?? .typeCastingFromErrorFailed(self.localizedDescription)
    }
}


