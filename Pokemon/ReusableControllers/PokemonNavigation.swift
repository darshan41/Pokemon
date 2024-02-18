//
//  PokemonNavigation.swift
//  Pokemon
//
//  Created by Darshan S on 12/02/24.
//

import UIKit

protocol MainNavigable: UIViewController {
    var mainDelegate: MainDelegte? { get set }
}

class PokemonNavigation: UINavigationController {
    
    weak var mainDelegate: MainDelegte?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    required init(rootViewController: MainNavigable,delegate: MainDelegte) {
        self.mainDelegate = delegate
        rootViewController.mainDelegate = delegate
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonNavigation {
    
    func configureView() {
        
    }
}
