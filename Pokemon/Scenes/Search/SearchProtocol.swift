//
//  SearchProtocol.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit
import PokemonAPI

protocol SearchViewProtocol: AnyObject,AnyVIPView {
    
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
    
    func navigateToInfoView(with pkpPokemon: PKPPokemon)
}

extension SearchPresenterProtocol {
    
    func getEndPoints() {
        interactor.getEndPoints()
    }
    
    func navigateToInfoView(with pkpPokemon: PKPPokemon) {
        router.navigateToInfoView(from: view, with: pkpPokemon)
    }
}

extension SearchPresenterProtocol {
    
}

protocol SearchInteractorOutputProtocol: AnyObject {
    
    func onSuccess()
    func onFailure(with error: APIManagerError)
}

protocol SearchRouterProtocol: AnyObject {
    
    func navigateToInfoView(from view: AnyVIPView?,with pkpPokemon: PKPPokemon)
}

extension SearchRouterProtocol {
    
    func navigateToInfoView(from view: AnyVIPView?,with pkpPokemon: PKPPokemon) {
        view?.navigationController?.pushViewController(PokeInfoView.create(with: pkpPokemon), animated: true)
    }
}

protocol PokemonGettable: AnyObject,ObservableObject {
    
}

