//
//  Stack.swift
//  Pokemon
//
//  Created by Darshan S on 25/02/24.
//

import Foundation

public protocol Stackable: Sequence {
    
    associatedtype Element
    
    mutating func push(_ element: Element)
    
    @discardableResult
    mutating func pop() -> Element?
}

public protocol ExtraStackable: Stackable {
    
    associatedtype Element
    
    /// Top Most Element Of Stack.
    func peek() -> Element?
    
    var isEmpty: Bool { get }
    
}

public struct Stack<Element>: ExtraStackable {
    
    public private (set)var storage: [Element] = []
    
    public init() { }
    
    public init(with array: [Element]) {
        self.storage = array
    }
}

// MARK: CustomStringConvertible

extension Stack: CustomStringConvertible {
    
    public var description: String {
        let topDivider: String = "----Top Part----\n"
        let bottomDivider: String = "\n----Bottom Part----"
        let reverseStackedStorage: String = storage
            .map { "\($0)" }
            .reversed()
            .joined(separator: "/n")
        return topDivider + reverseStackedStorage + bottomDivider
    }
}

// MARK: ExpressibleByArrayLiteral

extension Stack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        self.init(with: elements)
    }
}

// MARK: Stack where Element extends CustomStringConvertible

extension Stack where Element: CustomStringConvertible {
    
    public var description: String {
        let topDivider: String = "----Top Part----\n"
        let bottomDivider: String = "\n----Bottom Part----"
        let reverseStackedStorage: String = storage
            .map { $0.description }
            .reversed()
            .joined(separator: "/n")
        return topDivider + reverseStackedStorage + bottomDivider
    }
}

// MARK: Stackable

public extension Stack {
    
    mutating func push(_ element: Element) {
        self.storage.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        self.storage.popLast()
    }
    
    func peek() -> Element? { self.storage.last }
    
    var isEmpty: Bool { self.storage.isEmpty }
}

// MARK: Helper func's

private extension Stack { }

extension Stackable {
    
    public func makeIterator() -> AnyIterator<Element> {
        var curr = self
        return AnyIterator {
            return curr.pop()
        }
    }
}

