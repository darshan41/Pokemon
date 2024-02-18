//
//  String.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

extension String {
    static func error(_ errorMessages: ErrorMessages) -> String {
        return errorMessages.showableDescription
    }
}



// MARK: String

extension String? {
    
    var isValidString: Bool { (self != nil) && self!.isValid  }
    
    var asURL: URL? {
        self == nil ? nil : URL(string: self!)
    }
}

extension String {
   
    var firstServiceParam: String { "?"+self+"=" }
    var serviceParam: String { "&"+self+"=" }
    var identifierParam: String { "{"+self+"}" }
    
    var isValid: Bool { !self.isEmpty }
    
    /// Give parameter twice in dictionary and it will override it.
    func constantParametersForGetURL(
        defaultParameters: Set<Parameters>? = nil,
        addtionalParametersForGet: BasicDict?,
        identifiersForParam: BasicDict? = nil
    ) -> String {
        var baseURL = self
        var allURLParams: BasicDict = addtionalParametersForGet ?? [:]
        if let identifiers = identifiersForParam {
            for identifier in identifiers {
                if let identifierForParameter = identifier.value {
                    baseURL = baseURL.replacingOccurrences(
                        of: identifier.key.identifierParam,
                        with: identifierForParameter
                    )
                } else {
                    guard let defaultvalue = Parameters(rawValue: identifier.key)?.defalutValue else { continue }
                    baseURL = baseURL.replacingOccurrences(
                        of: identifier.key.identifierParam,
                        with: defaultvalue
                    )
                }
            }
        }
        if let parameters = defaultParameters {
            for parameter in parameters {
                guard let paramValue = Parameters.getValue(parameter) else { continue }
                allURLParams[parameter.rawValue] = paramValue
            }
        }
        if let addtionalParametersForGet {
            let queryString = addtionalParametersForGet.compactMap { key, value in
                guard let value = value else { return nil }
                return "\(key)=\(value)"
            }.joined(separator: "&")
            if !queryString.isEmpty {
                baseURL += baseURL.contains("?") ? "&" : "?"
                baseURL += queryString
            }
        }
        return baseURL
    }
    
    func isValidEmail() -> Bool {
        let inputRegEx = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:self)
    }
    
    func isValidPassword() -> Bool {
        let passRegEx = "^(?=.*[A-Za-z0-9])[A-Za-z0-9\\W]{6,}$"
        let passred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passred.evaluate(with: self)
    }

    func isValidName() -> Bool {
        let inputRegEx = "^[a-zA-Z](?:[a-zA-Z\\s][^\n]*)[a-zA-Z]$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:self)
    }
    
    func isValidZipCode() -> Bool {
        
        return true
    }
    
    func checkParams(with params: ParamSet) -> APIManagerError? {
        let paramsRequired = Set(params.filter({ !self.contains($0.rawValue + "=") }).map({ $0.rawValue }))
        guard paramsRequired.isEmpty else { return .getParametersAreNotSatisfied(parametersRequired: paramsRequired) }
        return nil
    }
}

// MARK: Optional Wrapped == String

extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool { (self == nil || self == "") ? true : false }
    
    /// Give parameter twice in dictionary and it will override it.
    func constantParametersForGetURL(
        _ parameters: ParamSet? = nil,
        identifiersForParam identifiers: BasicDict? = nil
    ) -> String {
        guard var baseURL = self else { return "" }
        if let parameters = parameters {
            for parameter in parameters {
                guard let paramValue = Parameters.getValue(parameter) else { continue }
                if parameter != parameters.first {
                    baseURL += paramValue
                } else {
                    baseURL += paramValue.replacingOccurrences(of: "&", with: "?")
                }
            }
        }
        if let identifiers = identifiers {
            for identifier in identifiers {
                if let identifierForParameter = identifier.value {
                    baseURL = baseURL.replacingOccurrences(
                        of: identifier.key.identifierParam,
                        with: identifierForParameter
                    )
                } else {
                    guard let defaultvalue = Parameters.init(rawValue: identifier.key)?.defalutValue else { continue }
                    baseURL = baseURL.replacingOccurrences(
                        of: identifier.key.identifierParam,
                        with: defaultvalue
                    )
                }
            }
        }
        return baseURL
    }
    
    var firstOne: String? {
        self == nil ? nil : String((self?.first)!)
    }
}

public extension Optional where Wrapped == Int {
    
    var toString: String {
        guard let self = self else { return "" }
        return String(self)
    }
}


extension String {
    
    func replaceWithEmptyString(_ all: [String]) -> String  {
        var string = self
        for aString in all {
            string = string.replacingOccurrences(of: aString, with: "")
        }
        return string
    }
//    
//    func getURLLinkedAttributedString(
//        textView: UITextView,
//        _ info: URLLinkedAttributeInfo
//    ) -> NSMutableAttributedString {
//        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = NSTextAlignment.center
//        let stringThatShouldBeColoured = self.sliceMultipleTimes(
//            from: info.firstComponent,
//            to: info.lastComponent
//        )
//        let attributedString = NSMutableAttributedString(
//            string: self.replaceWithEmptyString([
//                info.firstComponent,info.lastComponent
//            ]),
//            attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle]
//        )
//        let charCount = NSMakeRange(0, attributedString.string.count)
//        attributedString.apply(
//            font: info.font,
//            onRange: charCount
//        )
//        attributedString.apply(
//            color: info.foregroundColor,
//            onRange: charCount
//        )
//        attributedString.apply(
//            color: info.colorForOtherSubString,
//            subStrings: stringThatShouldBeColoured
//        )
//        if !info.urlLinkedStrings.isEmpty  {
//            ///Need to implement UITextViewDelegate
//            for dictionary in info.urlLinkedStrings {
//                let linkRange = attributedString.mutableString.range(of: dictionary.key)
//                attributedString.addAttribute(
//                    .link,
//                    value: dictionary.value,
//                    range: linkRange
//                )
//            }
//            textView.linkTextAttributes = [
//                NSAttributedString.Key.foregroundColor : info.urlLinkForegroundColor
//            ]
//        }
//        attributedString.underLine(subString: stringThatShouldBeColoured.joined())
//        return attributedString
//    }
    
    func sliceMultipleTimes(from: String = "<", to:  String = ">") -> [String] {
        components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
}
