//
//  PublicProtocols.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

public protocol ValueCheckable {
    
    func hasAnyNilValue() -> Bool
}

extension ValueCheckable {
    
    /// Checks properties that are string whether it's empty or nil
    func hasAnyNilValue() -> Bool {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let value = child.value as? String, value.isEmpty {
                return true
            }
        }
        return false
    }
}
