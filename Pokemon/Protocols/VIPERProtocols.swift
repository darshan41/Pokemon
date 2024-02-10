//
//  VIPERProtocols.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

public protocol ErrorShowable: Error {
    var showableDescription: String { get }
}

extension String: ErrorShowable {
    public var showableDescription: String { self }
}


public protocol AnyVIPView: AnyObject {
    
    var parent: UIViewController? { get }
    
    var presentingViewController: UIViewController? { get }
    
    var embedderViewController: UIViewController? { get }
    
    var overridedPresentationController: UIViewController? { get }
    
    var navigationController: UINavigationController? { get }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    
    func push(_ viewControllerToPush: UIViewController,animated flag: Bool)
    
    func onFailure(with error: ErrorShowable)
}

public protocol AnyVIPPresenter: AnyObject {
    var view: AnyVIPView? { get set }
    
    func onFailure(with error: ErrorShowable)
}

extension AnyVIPPresenter {
    
    func onFailure(with error: ErrorShowable) {
        view?.onFailure(with: error)
    }
}

public extension AnyVIPView {
    
    var embedderViewController: UIViewController? { self.parent }
    
    var overridedPresentationController: UIViewController? { nil }
    
    func push(_ viewControllerToPush: UIViewController,animated flag: Bool) {
        guard let nav = self.navigationController else {
            debugPrint("AnyVIPView: No NavigationController present")
            return
        }
        nav.pushViewController(viewControllerToPush, animated: flag)
    }
    
    func onFailure(with error: ErrorShowable) { }
}


typealias CanBecomeParameter = Encodable & Decodable  & Comparable

public protocol Describable {
    var typeName: String { get }
}

public extension Describable {
    
    var typeName: String {
        return String(describing: Self.self)
    }
}
