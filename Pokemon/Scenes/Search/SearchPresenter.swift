//
//  SearchPresenter.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation

class SplashPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    let interactor: SplashInteractor
    let router: SearchRouterProtocol
    
    init(interactor: SplashInteractor,router: SearchRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Interactor's Output

extension SplashPresenter: SearchInteractorOutputProtocol {
    
    func onSuccess() {
        view?.onSuccess()
    }
    
    func onFailure(with error: APIManagerError) {
        view?.onFailure(with: error)
    }
}

// MARK: Router Handling

extension SplashPresenter { }

