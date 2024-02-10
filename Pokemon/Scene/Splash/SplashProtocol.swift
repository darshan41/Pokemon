//
//  SplashProtocol.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit
import PokemonAPI

protocol SplashViewProtocol: AnyObject {
    
    var presenter: SplashPresenterProtocol! { get set }
    
    func onSuccess()
    func onFailure(with error: APIManagerError)
    
}

protocol SplashInteractorInputProtocol: AnyObject {
    
    var presenter: SplashInteractorOutputProtocol? { get set }
    
    func getEndPoints()
}

extension SplashInteractorInputProtocol {
    
}

protocol SplashPresenterProtocol: AnyObject {
    
    var view: SplashViewProtocol? { get set }
    var interactor: SplashInteractor { get }
    var router: SplashRouterProtocol { get }
    
    func getEndPoints()
}

extension SplashPresenterProtocol {
    
    func getEndPoints() {
        interactor.getEndPoints()
    }
}

extension SplashPresenterProtocol {
    
}

protocol SplashInteractorOutputProtocol: AnyObject {
    
    func onSuccess()
    func onFailure(with error: APIManagerError)
}

protocol SplashRouterProtocol: AnyObject {
    
}

protocol PokemonGettable: AnyObject,ObservableObject {
    
}

