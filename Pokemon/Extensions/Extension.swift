//
//  Extension.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import UIKit

// MARK: Array

extension Int {
    
    var daySuffix: String {
        switch self {
        case 1,21,31:
            return "st"
        case 2,22:
            return "nd"
        case 3,23:
            return "rd"
        default:
            return "th"
        }
    }
    
    func liesInside(_ initial: Int,_ final: Int) -> Bool {
        (self > initial && self < final) ? true : false
    }
    
    func liesIncludingInitial(_ initial: Int,_ final: Int) -> Bool {
        (self >= initial || liesInside(initial, final)) && self < final
    }
    
    func liesIncludingFinal(_ initial: Int,_ final: Int) -> Bool {
        (self <= final || liesInside(initial, final)) && self > initial
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
}

// MARK: RawRepresentable

extension RawRepresentable {
    
    init?(anyVal: Any?) {
        if let anyVal = anyVal as? RawValue {
            self.init(rawValue: anyVal)
        } else {
            return nil
        }
    }
    
    init?(optRawValue: RawValue?) {
        if let str = optRawValue {
            self.init(rawValue: str)
        } else {
            return nil
        }
    }
    
    func convertRaw<T: RawRepresentable>() -> T? where T.RawValue == RawValue {
        T(rawValue: self.rawValue)
    }
}

// MARK: Encodable

extension Encodable {
    
    func encoded() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

// MARK: Array Element: RawRepresentable

extension Array where Element: RawRepresentable {
    
    internal func convertToOptionalRaws<T: RawRepresentable>() -> Array<T> where T.RawValue == Element.RawValue {
        let wrapped: [T?] = self.map { $0.convertRaw() }
        return wrapped.filter { $0 != nil } as! [T]
    }
    
    internal func convertToRaws<T: RawRepresentable>() -> Array<T> where T.RawValue == Element.RawValue {
        let wrapped: [T] = self.compactMap { $0.convertRaw() }
        return wrapped
    }
}

// MARK: Array Element == String

extension Array where Element == String {
    
    func toEnums<T: RawRepresentable>() -> [T] where T.RawValue == String {
        let wrapped: [T] = self.compactMap { T(rawValue: $0) }
        return wrapped
    }
}

// MARK: BasicDict

extension BasicDict {
    
    var queryItems: [URLQueryItem] {
        self.compactMap({ URLQueryItem(name: $0.key, value: $0.value ?? "") })
    }
    
    mutating func merging(_ anathor: Self?) {
        guard let anathor = anathor else { return }
        for dict in anathor {
            self[dict.key] = dict.value
        }
    }
    
    var toParameterDictionary: ParameterDictionary {
        var dict: ParameterDictionary = [:]
        for aDict in self {
            guard let key = Parameters(rawValue: aDict.key) else { continue }
            dict[key] = aDict.value
        }
        return dict
    }
}

// MARK: Set

extension Set where Element == Parameters {
    
    func serialize() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

// MARK: ParamSet

extension ParamSet {
    
    func filterOutMissing(as other: Self?) -> Self {
        guard let other = other else { return self }
        return self.filter({ !other.contains($0) })
    }
    
    func filterOutMissing(as other: BasicDict?) -> Self {
        guard let other = other else { return self }
        return self.filter({ element in !other.contains(where: { $0.value != nil && $0.key == element.rawValue }) })
    }
    
    func filterOutMissing(as other: ParameterDictionary?) -> Self {
        guard let other = other else { return self }
        return self.filter({ !other.keys.contains($0) })
    }
}

extension Dictionary where Key == String, Value == Optional<String> {
    
    func filterOutMissing(with anathorDict: Self?) -> Self {
        guard let anathorDict = anathorDict else { return self }
        return self.filter({ !anathorDict.keys.contains($0.key) })
    }
    
    func filterOutMissing(with anathorDict: Self?) -> Set<Key> {
        guard let anathorDict = anathorDict else { return Set(self.keys) }
        return Set(self.filter({ !anathorDict.keys.contains($0.key) }).keys)
    }
    
    func removingNilValues() -> [String: String] {
        var cleanDict: [String: String] = [:]
        for element in self {
            guard let value = element.value else { continue }
            cleanDict[element.key] = value
        }
        return cleanDict
    }
}

extension Dictionary where Key == Parameters, Value == Optional<String> {
    
    func filterOutMissing(with anathorDict: Self?) -> Self {
        guard let anathorDict = anathorDict else { return self }
        return self.filter({ !anathorDict.keys.contains($0.key) })
    }
    
    func filterOutMissing(with anathorDict: Self?) -> Set<Key> {
        guard let anathorDict = anathorDict else { return Set(self.keys) }
        return Set(self.filter({ !anathorDict.keys.contains($0.key) }).keys)
    }
}

extension Set where Element == String {
    
    func isThereACommonElement(with anathorSet: Optional<Set<String>>) -> Bool {
        !self.intersection(anathorSet ?? []).isEmpty
    }
}

extension Optional where Wrapped == Set<String>   {
    
    func isThereACommonElement(with anathorSet: Optional<Set<String>>) -> Bool {
        !(self?.intersection(anathorSet ?? []).isEmpty ?? true)
    }
}

extension ParameterDictionary {
    
    var toParamDictionary: BasicDict {
        var dict: BasicDict = [:]
        self.forEach({ dict[$0.key.rawValue] = $0.value })
        return dict
    }
}

// MARK: Dictionary

extension Dictionary {
    
    func serialize() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

// MARK: Dictionary String: Any

extension Dictionary where Key == String, Value == Any {
    
    func removeValues(with keys: [String]) -> [String:Any] {
        return self.filter({!keys.contains($0.key)})
    }
    
    func toParamString() -> [String: String] {
        return self.compactMapValues { $0 as? String }
    }
}

// MARK: NSObject

extension NSObject {
    
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}

extension UIImage.Configuration {
    
    static var backConfig: UIImage.SymbolConfiguration {
        .init(font: .monospacedSystemFont(ofSize: 16, weight: .medium))
    }
    
}

func delay(_ delayTime: DispatchTime? = nil,_ handler: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: delayTime ?? .now(), execute: handler)
}

