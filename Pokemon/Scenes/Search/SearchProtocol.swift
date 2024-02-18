//
//  SearchProtocol.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit
import PokemonAPI

protocol SearchViewProtocol: AnyObject {
    
    var presenter: SearchPresenterProtocol! { get set }
    
    func onSuccess()
    func onFailure(with error: APIManagerError)
    
}

protocol SearchInteractorInputProtocol: AnyObject {
    
    var presenter: SearchInteractorOutputProtocol? { get set }
    
    func getEndPoints()
}

extension SearchInteractorInputProtocol {
    
}

protocol SearchPresenterProtocol: AnyObject {
    
    var view: SearchViewProtocol? { get set }
    var interactor: SplashInteractor { get }
    var router: SearchRouterProtocol { get }
    
    func getEndPoints()
}

extension SearchPresenterProtocol {
    
    func getEndPoints() {
        interactor.getEndPoints()
    }
}

extension SearchPresenterProtocol {
    
}

protocol SearchInteractorOutputProtocol: AnyObject {
    
    func onSuccess()
    func onFailure(with error: APIManagerError)
}

protocol SearchRouterProtocol: AnyObject {
    
}

protocol PokemonGettable: AnyObject,ObservableObject {
    
}

