//
//  SearchRouter.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

class SearchRouter: SearchRouterProtocol {
    
    class func createModule() -> SearchView {
        let view = SearchView.instantiateFromAppStoryBoard(appStoryBoard: .Search)
        let interactor: SplashInteractor = SplashInteractor()
        let router: SearchRouterProtocol = SearchRouter()
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SplashPresenter(interactor: interactor,router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
