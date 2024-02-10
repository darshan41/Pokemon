//
//  ServiceInfo.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

struct ServiceInfo {
    var serviceKey: Services.ServiceCodingKey?
    var serviceURL: String?
    var serviceMethod: ServiceMethod?
    var requiredParameters: ParamSet?
    var urlReplacingIdentifier: BasicDict?
    var requiredHeaders: BasicDict?
    var fitHeadersFromInfo: Bool?
    var useDefault: Bool?
    var maxTimeOuts: Int?
}
/// Highly Recursive depending on usage.
extension ServiceInfo {

    func addDefaultParamsWhereverNeccesary(with parameters: BasicDict? = nil) -> BasicDict? {
        if let serviceInfoParameters = self.requiredParameters {
            var newBasicDict: BasicDict = [:]
            let missedParameters = Set(serviceInfoParameters.filterOutMissing(as: parameters).compactMap({ $0 }))
            for parameter in missedParameters {
                guard let defalutValue = parameter.defalutValue else { continue }
                newBasicDict[parameter.rawValue] = defalutValue
            }
            for parameter in parameters ?? [:] {
                newBasicDict[parameter.key] = parameter.value
            }
            return newBasicDict
        }
        return parameters
    }
    
    mutating func customisedURL(additionalParmas: BasicDict?) -> String? {
        self.serviceURL?.constantParametersForGetURL(
            defaultParameters: (self.serviceMethod == .Get) ? self.requiredParameters : nil, addtionalParametersForGet: (self.serviceMethod == .Get) ? additionalParmas : nil,
            identifiersForParam: self.urlReplacingIdentifier
        ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    mutating func validate(additionalParmas: BasicDict?) throws -> URL {
        guard let _ = self.serviceMethod else { throw APIManagerError.unknownHttpMethod(givenMethod: self.serviceMethod) }
        guard let url = self.customisedURL(additionalParmas: additionalParmas).asURL else {
            throw APIManagerError.NextStepURLErrors(nxtSterpError: .NSURLErrorBadURL) }
        return url
    }
    
    static func serviceRequirementChecker(
        with serviceInfo: Self,
        parameters: BasicDict? = nil,
        replacingIdentifiers: BasicDict? = nil,
        headers: BasicDict? = nil
    ) throws -> URL {
        var serviceInfo = serviceInfo
        serviceInfo.urlReplacingIdentifier?.merging(replacingIdentifiers)
        let url = try serviceInfo.validate(additionalParmas: parameters)
        let headers = (serviceInfo.fitHeadersFromInfo ?? true) ? serviceInfo.requiredHeaders : headers
        let errors = [
            serviceInfo.paramChecker(
                parameters: parameters
            ),
            serviceInfo.replaceIdentifierChecker(
                with: url,
                replacingIdentifiers: replacingIdentifiers
            ),
            serviceInfo.headerChecker(
                headers: headers
            )
        ].compactMap({ $0 })
        guard errors.isEmpty else { throw APIManagerError.multipleErrors(errors: errors) }
        return url
    }
    
    static func serviceRequirementCheckerWithRawData(
        with serviceInfo: Self,
        replacingIdentifiers: BasicDict? = nil,
        headers: BasicDict? = nil,
        additionalParams: BasicDict?
    ) throws -> URL {
        var serviceInfo = serviceInfo
        serviceInfo.urlReplacingIdentifier?.merging(replacingIdentifiers)
        let url = try serviceInfo.validate(additionalParmas: additionalParams)
        let headers = (serviceInfo.fitHeadersFromInfo ?? true) ? serviceInfo.requiredHeaders : headers
        let errors = [
            serviceInfo.replaceIdentifierChecker(
                with: url,
                replacingIdentifiers: replacingIdentifiers
            ),
            serviceInfo.headerChecker(
                headers: headers
            )
        ].compactMap({ $0 })
        guard errors.isEmpty else { throw APIManagerError.multipleErrors(errors: errors) }
        return url
    }
}

/// Checker func's
private extension ServiceInfo {
    
    func replaceIdentifierChecker(
        with url: URL,
        replacingIdentifiers: BasicDict? = nil
    ) -> APIManagerError? {
        if let serviceInfoReplaceIdentifier = self.urlReplacingIdentifier {
            var errors = Set<String>()
            for identityDict in serviceInfoReplaceIdentifier {
                guard url.absoluteString.contains(identityDict.key.identifierParam) else { continue }
                errors.insert(identityDict.key)
            }
            return errors.isEmpty ? nil : .getParametersAreNotSatisfied(parametersRequired: errors)
        }
        return nil
    }
    
    func headerChecker(
        headers: BasicDict? = nil
    ) -> APIManagerError? {
        if let serviceInfoHeaders = self.requiredHeaders {
            guard headers == serviceInfoHeaders else {
                return .headersAreNotSatisfied(parametersRequired: serviceInfoHeaders.filterOutMissing(with: headers))
            }
        }
        return nil
    }
    
    func paramChecker(
        parameters: BasicDict? = nil
    ) -> APIManagerError? {
        guard let method = self.serviceMethod else { return .unknownHttpMethod(givenMethod: self.serviceMethod) }
        if let serviceInfoParameters = self.requiredParameters {
            if method == .Get {
                var urlStr = self
                guard let url = urlStr.customisedURL(additionalParmas: parameters) else {
                    return .nilParametersForGet
                }
                return url.checkParams(with: serviceInfoParameters)
            } else {
                let missedParameter = Set(serviceInfoParameters.filterOutMissing(as: parameters).compactMap({ $0.rawValue }))
                guard missedParameter.isEmpty else { return
                    method.insufficientDataError(with: missedParameter)
                }
            }
        }
        return nil
    }
    
}


