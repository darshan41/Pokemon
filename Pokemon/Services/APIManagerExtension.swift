//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

// MARK: Generic Result where Given struct must be codable

public struct PokemonError: Codable {
    
    typealias ReturnType = Self
    
    var message: String?
    var errors: [String:[String]]?
}

public protocol ErrorCheckable {
    var error: PokemonErrorType? { get }
    var success: Bool! { get }
}

// MARK: Required (JSON formats)

public enum PokemonErrorType {
    case errString(String)
    case appErrors(PokemonError)
}

// MARK: Keys that can be used for headers or MimeTypes

public enum URLSessionKey: String,CanBecomeParameter {
    
    typealias ReturnType = Self
    
    public static func < (lhs: URLSessionKey, rhs: URLSessionKey) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    case formUrlEncoded = "application/x-www-form-urlencoded"
    case contentType = "Content-Type"
    case accept = "Accept"
    case applicationJson = "application/json"
    
    var defaultValue: String {
        switch self {
        case .formUrlEncoded:
            return URLSessionKey.accept.rawValue
        case .contentType:
            return URLSessionKey.applicationJson.rawValue
        case .accept:
            return URLSessionKey.formUrlEncoded.rawValue
        case .applicationJson:
            return URLSessionKey.accept.rawValue
        }
    }
}

// MARK: Error that can be thrown by service

enum APIManagerError: Error,LocalizedError,Equatable {
    
    ///Checks from backend
    case nilParametersForGet
    case getParametersAreNotSatisfied(parametersRequired: Set<String>? = nil)
    case postParametersAreNotSatisfied(parametersRequired: Set<String>? = nil)
    case deleteParametersAreNotSatisfied(parametersRequired: Set<String>? = nil)
    case putParametersAreNotSatisfied(parametersRequired: Set<String>? = nil)
    case replacingIdentifiersNotSatisfied(parametersRequired: Set<String>? = nil)
    case headersAreNotSatisfied(parametersRequired: Set<String>? = nil)
    case errorWithCode(errorCode: String? = nil,errorString: String? = nil)
    
    // MARK: For Dev
    
    case invalidJSONForSerialisation
    case foundNilType
    case unableToStartWithoutExpectingReturnType
    case unrecognisedServiceMethod
    case noResponseFromServer
    case successIsFalseInResponse
    case successIsNullInResponse
    case gotCorruptedData
    case multipleErrors(errors: [APIManagerError]? = nil)
    case unknown(error: String? = nil)
    case invalidJSONFormat(error: String? = nil)
    case typeCastingFailed
    case typeCastingFromErrorFailed(String?)
    case FirebaseError(error: String? = nil)
    case internalServerError
    case offline
    case unknownHttpMethod(givenMethod: ServiceMethod? = nil)
    case conversionFailedToHTTPURLResponse
    
    ///ServiceInfo Errors
    case invalidServiceInformation(key: ServicesCodingKeys)
    case failedToFindService
    case failedToValidateServiceInformation(key: String?)
    case unreachableConfig
    
    // MARK: URL Session Error Codes.
    case URLErrors(statusCode: Int)
    case NextStepURLErrors(nxtSterpError: NSURLErrors)
    case methodNotAllowed(currentMethod: ServiceMethod? = nil, error: String? = nil)
    case notFound
    // MARK: Showable
    
    case somethingWentWrong
    case pokemonError(error: String? = nil)
}

// MARK: User Protocol Extensions

// MARK: ErrorCheckable

extension ErrorCheckable {
    
    func validateError() -> APIManagerError? {
        if let error = error {
            switch error {
            case .errString(let strError):
                return .pokemonError(error: strError)
            case .appErrors(let pokemonError):
                return .pokemonError(error: pokemonError.customisedError())
            }
        }
        return nil
    }
}

// MARK: Enum Extensions

// MARK: APICallerError - LocalizedError

extension APIManagerError: ErrorShowable {
    
    var paramsError: String? {
        switch self {
        case .nilParametersForGet,.getParametersAreNotSatisfied(_):
            return "GET"
        case .postParametersAreNotSatisfied(_):
            return "POST"
        case .deleteParametersAreNotSatisfied(_):
            return "Delete"
        case .putParametersAreNotSatisfied(_):
            return "Put"
        case .replacingIdentifiersNotSatisfied(_):
            return "Identifier Replacer"
        default:
            return nil
        }
    }
    
    var showableError: Self {
        if isDeveloperMode {
            return self
        } else {
            switch self {
            case .internalServerError,
                    .offline,
                    .pokemonError(_):
                return self
            default:
                return .somethingWentWrong
            }
        }
    }
    
    var showableDescription: String {
        return self.showableError.errorDescription ?? .error(.somethingWentWrong)
    }
    
    // MARK: Description of error,the error from alamofire is thrown in afError
    
    var errorDescription: String? {
        switch self {
        case .foundNilType:
            return "The Data type is found to be nil"
        case .successIsFalseInResponse:
            return "Success In Response is Found to be false."
        case .successIsNullInResponse:
            return "Success In Response is Found to be nil."
        case .somethingWentWrong:
            return .error(.somethingWentWrong)
        case .gotCorruptedData:
            return "Response data Was found nil while error is nil and success is true... \n or \n Might Data be corrupted."
        case .unknownHttpMethod:
            return "The HTTP Method Passed is not recognised."
        case .unreachableConfig:
            return "Cannot Load Home Screen Something Went Wrong!"
        case .invalidServiceInformation(let key):
            return "Error Finding Service\(isDeveloperMode ? ", ErrorDesc: \(key.rawValue)" : ".")"
        case .getParametersAreNotSatisfied(let parameters),
                .postParametersAreNotSatisfied(let parameters),
                .deleteParametersAreNotSatisfied(let parameters),
                .replacingIdentifiersNotSatisfied(let parameters):
            return "\((parameters?.isEmpty) == nil ? "Parameters are" : "These parameters are") required! \"\(self.paramsError ?? "")\" and is not fed by app! \n  \((parameters?.compactMap({ $0 }).joined(separator: " \n ") ?? ""))"
        case .headersAreNotSatisfied(let parameters):
            return "\((parameters?.isEmpty) == nil ? "Headers are" : "These headers are") required! and is not fed by app! \n  \((parameters?.compactMap({ $0 }).joined(separator: " \n ") ?? ""))"
        case .multipleErrors(let apimanagerErrors):
            if let apimanagerErrors = apimanagerErrors?.filter({ $0 != .multipleErrors() }),
               !apimanagerErrors.isEmpty {
                return " \n ----------------------- \n " + apimanagerErrors.compactMap({ $0.errorDescription }).joined(separator: "\n ----+---- \n") + " \n ----------------------- \n "
            } else {
                return "Something Went Wrong!!! from multiple error block."
            }
        case .errorWithCode(let errorCodeStr,let errorString):
            return errorCodeStr ?+? " \(errorString ?? " Response Error \n  \(String.error(.somethingWentWrong))")"
        case .methodNotAllowed(let method,let error):
            return "Http Method Not Allowed \(method?.rawValue == nil ? "" : "Current method \(method!.rawValue)") \n \(error ?? "")"
        case .unknown(let error),
                .invalidJSONFormat(let error):
            return NSLocalizedString("\(error ?? "Something went wrong")" , comment: "Response Error")
        case .unableToStartWithoutExpectingReturnType:
            return "The Parameter or expecting type is found to be empty"
        case .URLErrors(let statusCode):
            return NSURLErrors.init(rawValue: statusCode)?.showableDescription ?? "Failed To Catch NextStep Errors "
        case .nilParametersForGet:
            return "Parameter was expected from backend in get but found to be nil"
        case .NextStepURLErrors(let nsError):
            return nsError.showableDescription
        case .pokemonError(let error):
            return error ?? .error(.somethingWentWrong)
        case .offline:
            return ErrorMessages.offline.text
        case .internalServerError:
            return "Something went wrong!"
        default:
            return "\(self)"
        }
    }
}

// MARK: PokemonErrorType - Decodable

extension PokemonErrorType: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let pokemonError = try container.decode(PokemonError.self)
            self = .appErrors(pokemonError)
        } catch DecodingError.typeMismatch {
            let errorString = try container.decode(String.self)
            self = .errString(errorString)
        }
    }
}

// MARK: PokemonErrorType - Encodable

extension PokemonErrorType: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .errString(let error):
            try container.encode(error)
        case .appErrors(let error):
            try container.encode(error)
        }
    }
}

// MARK: URLRequest

extension URLRequest {
    
    mutating func defaultHeaders() {
        self.addValue(
            URLSessionKey.applicationJson.rawValue,
            forHTTPHeaderField: URLSessionKey.contentType.rawValue
        )
        self.addValue(
            URLSessionKey.applicationJson.rawValue,
            forHTTPHeaderField: URLSessionKey.accept.rawValue
        )
    }
    
    mutating func addHeaders(from headers: BasicDict? = nil) {
        guard let headers = headers,
              !headers.isEmpty else {
            self.defaultHeaders()
            return
        }
        self.defaultHeaders()
        for header in headers {
            guard let headerValue = header.value else { continue }
            self.addValue(headerValue, forHTTPHeaderField: header.key)
        }
    }
}

extension PokemonError {
    
    func customisedError() -> String {
        let errors = self.errors?.compactMap({$0.value.joined(separator:" \n -")}).joined(separator: " \n -")
        if let message = self.message,
           let errors = errors {
            return (message + " \n -" + errors)
        } else if(message == nil && errors != nil) {
            return errors ?? somethingWentWrong
        } else {
            return somethingWentWrong
        }
    }
}

// MARK: Error To APIManagerError

extension Optional where Wrapped == Error {
    
    func checkResponseError() -> APIManagerError? {
        guard let error = self else {
            return nil }
        if let nsError = NSURLErrors.init(rawValue: error._code) {
            if (500...599).contains(error._code) {
                return .internalServerError
            } else {
                return .NextStepURLErrors(nxtSterpError: nsError)
            }
        } else {
            if (500...599).contains(error._code) {
                return .internalServerError
            } else {
                return .URLErrors(statusCode: error._code)
            }
        }
    }
}

// MARK: ErrorWithCode XTension

extension Optional where Wrapped == BasicDict {
    
    func returnError(with error: Error?) -> APIManagerError? {
        guard let error = error,
              let pickedError = self?.first(where: { "\($0.key)" == "\(error._code)" }) else {
            return nil
        }
        return .errorWithCode(errorCode: pickedError.key, errorString: pickedError.value)
    }
}


