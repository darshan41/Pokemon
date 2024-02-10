//
//  SplashView.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

// Thanks to Paul Hallett and PokéAPI Team, for giving resources in order to learn.

import UIKit
import SwiftUI

final class SplashView: UIViewController {
    
    var presenter: SplashPresenterProtocol!
    
    private weak var previousViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previousViewController?.view.layoutIfNeeded()
    }
}

// MARK: Presenter to View Protocol

extension SplashView: SplashViewProtocol {
    
    func onSuccess() {
        self.previousViewController?.dismiss(animated: true)
        let object: SearchObject<Pokemonz,SplashInteractor> = SearchObject(tableObservable: self.presenter.interactor)
        let swiftUIView = UIHostingController(rootView: Table(title: "Search Pokemons", searchData: object))
        ViewEmbedder.embedWithCons(parent: self, container: view, child: UINavigationController(rootViewController: swiftUIView), previous: nil)
        self.previousViewController = swiftUIView
    }
    
    func onFailure(with error: APIManagerError) {
        self.previousViewController?.dismiss(animated: true)
        let swiftUIErrorView = UIHostingController(rootView: ErrorView(error: error.showableDescription, title: "Retry", retryAction: { [weak self] in
            self?.presenter.getEndPoints()
        }))
        ViewEmbedder.embedWithCons(parent: self, container: view, child: UINavigationController(rootViewController: swiftUIErrorView), previous: nil)
        self.previousViewController = swiftUIErrorView
    }
}

// MARK: Helper func's

private extension SplashView {
    
    func configureView() {
        view.backgroundColor = Color.fillColor(Color.currentScheme).toUIColor
        let swiftUIView = UIHostingController(rootView: CenteredGifView())
        ViewEmbedder.embedWithCons(parent: self, container: view, child: UINavigationController(rootViewController: swiftUIView), previous: previousViewController)
        self.previousViewController = swiftUIView
        presenter.getEndPoints()
    }
}


