//
//  SplashPresenter.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation

class SplashPresenter: SplashPresenterProtocol {
    
    weak var view: SplashViewProtocol?
    let interactor: SplashInteractor
    let router: SplashRouterProtocol
    
    init(interactor: SplashInteractor,router: SplashRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Interactor's Output

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func onSuccess() {
        view?.onSuccess()
    }
    
    func onFailure(with error: APIManagerError) {
        view?.onFailure(with: error)
    }
}

// MARK: Router Handling

extension SplashPresenter { }

