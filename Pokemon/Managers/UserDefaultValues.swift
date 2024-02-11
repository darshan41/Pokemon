//
//  File.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import Foundation

enum UserDefaultKeys: String,CaseIterable {
    case hasSeenAppintro = "hasSeenAppintro"
    case lastUpdatedDate = "lastUpdatedDate"
    var appKey: String { "com.\(self.rawValue).AppVentures" }
    
    fileprivate static func removeValuesRelatedToKeys() {
        Self.allCases.forEach({ UserDefaults.standard.removeObject(forKey: $0.appKey) })
    }
}

@propertyWrapper
struct UserDefault<Value> {
    
    let key: UserDefaultKeys
    let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            UserDefaults.standard.value(forKey: key.appKey) as? Value ?? self.defaultValue
        } set {
            UserDefaults.standard.set(newValue, forKey: key.appKey)
        }
    }
    
    var projectedValue: Self { self }
    
    func removeValue() {
        UserDefaults.standard.removeObject(forKey: key.appKey)
    }
}

struct UserDefaultValues {
    
    @UserDefault(key: .hasSeenAppintro, defaultValue: false)
    static var hasSeenAppintro: Bool
    
    @UserDefault(key: .lastUpdatedDate, defaultValue: Date())
    static var lastUpdatedDate: Date
    
    func removeAllValues() {
        UserDefaultKeys.removeValuesRelatedToKeys()
    }
}


