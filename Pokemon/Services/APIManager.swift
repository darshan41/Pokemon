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

struct Response<SomeDecodable: Codable>: pokemonResult {
    
    var success: Bool!
    var data: SomeDecodable?
    var error: PokemonErrorType?
    
    static var defaultFailureResponse: Response {
        Response(
            success: false,
            data: nil,
            error: .errString(somethingWentWrong)
        )
    }
    
    func validateResponse() -> Result<SomeDecodable,APIManagerError> {
        if let error = self.validateError() {
            return .failure(error)
        }
        if let success = success,!success {
            return .failure(.successIsFalseInResponse)
        } else {
            guard let data = self.data else {
                return .failure(.gotCorruptedData)
            }
            return .success(data)
        }
    }
}

// MARK: Rather than class expose Protocols

protocol APIManagerProtocol {
    
    var session: URLSession { get }
    
    func request<SomeModel:  Codable>(
        _ url: URL,
        expectingReturnType: SomeModel.Type,
        _ httpMethod: ServiceMethod,
        _ body: Data?,
        _ headers: BasicDict?,
        _ urlSession: URLSession?,
        _ supplementaryURLRequest: URLRequest?
    ) async throws -> SomeModel
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
    func request<SomeModel: Codable>(
        _ url: URL,
        expectingReturnType: SomeModel.Type,
        _ httpMethod: ServiceMethod,
        _ body: Data?,
        _ headers: BasicDict?,
        _ urlSession: URLSession? = nil,
        _ supplementaryURLRequest: URLRequest? = nil
    ) async throws -> SomeModel {
        let session = urlSession ?? session
        var request = supplementaryURLRequest ?? URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            request.httpBody = body
        }
        request.addHeaders(from: headers)
        do {
            let data: SomeModel = try await self.responseHandler(session.data(for: request, delegate: nil))
            return data
        } catch let error {
            try error.codeChecker()
            throw APIManagerError.somethingWentWrong
        }
    }
}

extension APIManager {
    
    func responseHandler<SomeModel: Codable>(_ asyncResponsiveData: APIManagerAsyncData) async throws -> SomeModel {
        guard let response = asyncResponsiveData.response as? HTTPURLResponse else {
            throw APIManagerError.conversionFailedToHTTPURLResponse
        }
        return try await decode(data: asyncResponsiveData.data,resposne: response)
    }
    
    func decode<SomeModel: Codable>(data: Data,resposne: HTTPURLResponse) async throws -> SomeModel {
        debugPrint("The Data Fed To Decoder format is of \(String(describing: SomeModel.self))")
        debugPrint("""
URL: \(resposne.url?.absoluteString ?? "None"),
StatusCode: \(resposne.statusCode)
"""
        )
        return try self.decoder.decode(SomeModel.self, from: data)
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
    
    // MARK: Handling Decoding Part and error part via Response(Required Struct which Conforms To ErrorCheckable)
    
    func responseHandler<SomeModel: Codable>(
        _ responseData: (URLResponse?,(Data?,Error?)),
        onCompletion: PokemonResult<SomeModel>
    )  {
        guard let response = responseData.0 as? HTTPURLResponse else {
            if let error = responseData.1.1 {
                do {
                    try error.codeChecker()
                    return
                } catch {
                    onCompletion(.failure(error.castedToAPIManagerError))
                }
            } else {
                onCompletion(.failure(.conversionFailedToHTTPURLResponse))
            }
            return
        }
        do {
            if isDeveloperMode {
                try response.statusCodeChecker()
                if let error = responseData.1.1 {
                    onCompletion(.failure(error.castedToAPIManagerError))
                } else {
                    onCompletion(decode(data: responseData.1.0))
                }
            } else {
                if let error = responseData.1.1 {
                    onCompletion(.failure(error.castedToAPIManagerError))
                    return
                } else {
                    let decodedData: Result<SomeModel,APIManagerError> = decode(data: responseData.1.0)
                    switch decodedData {
                    case .success(let success):
                        onCompletion(.success(success))
                        return
                    case .failure(let failure):
                        onCompletion(.failure(failure))
                        return
                    }
                }
//                try response.statusCodeChecker()
            }
        } catch let error {
            onCompletion(.failure(error.castedToAPIManagerError))
            return
        }
    }
    
    func decode<SomeModel: Codable>(
        data: Data?,
        expectingType: SomeModel.Type = SomeModel.self
    ) -> Result<SomeModel,APIManagerError> {
        guard let data else {
            return .failure(.gotCorruptedData)
        }
        debugPrint("The Data Fed To Decoder format is of \(String(describing: SomeModel.self))")
        do {
            let model: SomeModel = try decoder.decode(SomeModel.self, from: data)
            return .success(model)
        } catch {
            return .failure(.invalidJSONFormat(error: error.localizedDescription))
        }
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


