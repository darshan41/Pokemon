//
//  RootView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit

final class RootView: UIViewController,MainNavigable {
    
    weak var mainDelegate: MainDelegte?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    static func createRoot() -> RootView {
        let rootView: RootView = RootView.instantiateFromAppStoryBoard(appStoryBoard: .Main)
        return rootView
    }
}

// MARK: Helper func's

private extension RootView {
    
    func configureView() {
        let tab = TabBarController.createTabBar()
        ViewEmbedder.embed(parent: self, container: view, child: tab, previous: nil)
        self.mainDelegate = tab
    }
}
