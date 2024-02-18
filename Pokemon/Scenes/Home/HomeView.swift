//
//  HomeView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit

final class HomeView: UIViewController,MainNavigable {
    
    @IBOutlet private weak var loader: CustomActivityIndicator!
    
    private let homeModel: HomeModel = HomeModel()
    
    weak var mainDelegate: MainDelegte?
    
    private var showLoader: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    static func createModule(_ delegate: MainDelegte) -> HomeView {
        return HomeView.instantiateFromAppStoryBoard(appStoryBoard: .Home)
    }
    
    deinit {
        debugPrint("💥 Deininting \(Self.self)")
    }
}

// MARK: Helper func's

private extension HomeView {
    
    func configureView() {
        self.showLoader = true
    }
}
