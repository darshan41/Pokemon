//
//  Operators.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

precedencegroup OptionalLeftAddition {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: left
    assignment: true
}

precedencegroup OptionalRightAddition {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: right
    assignment: true
}

precedencegroup OptionalAddition {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: none
    assignment: true
}

infix operator +? : OptionalLeftAddition
infix operator +/? : OptionalLeftAddition
infix operator ?+? : OptionalAddition
infix operator ?+ : OptionalRightAddition

func +/? <T: StringProtocol>(lhs: Optional<T>, rhs: Optional<T>) -> String? {
    if let lhs = lhs,let rhs = rhs {
        return lhs + ("/\(rhs)")
    } else if (lhs != nil && rhs == nil) {
        return lhs ?+? rhs
    } else if lhs == nil && rhs != nil {
        return "/" +? rhs
    } else { return nil }
}

func +? <T: StringProtocol>(lhs: Optional<T>, rhs: Optional<T>) -> String {
    guard let lhs = lhs else { return "" }
    return [lhs,(rhs ?? "")].joined()
}

func ?+ <T: StringProtocol>(lhs: Optional<T>, rhs: Optional<T>) -> String {
    guard let rhs = rhs else { return "" }
    return [(lhs ?? ""),rhs].joined()
}

func ?+? <T: StringProtocol>(lhs: Optional<T>, rhs: Optional<T>) -> String { [lhs,rhs].compactMap({ $0 }).joined() }


