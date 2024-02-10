//
//  SplashRouter.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    
    class func createModule() -> SplashView {
        let view = SplashView.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        let interactor: SplashInteractor = SplashInteractor()
        let router: SplashRouterProtocol = SplashRouter()
        let presenter: SplashPresenterProtocol & SplashInteractorOutputProtocol = SplashPresenter(interactor: interactor,router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
