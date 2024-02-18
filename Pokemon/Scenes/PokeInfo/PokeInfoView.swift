//
//  PokeInfoView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit

class PokeInfoView: UIViewController {
    
    var pkpPokemon: PKPPokemon?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    class func create(with pkpPokemon: PKPPokemon) -> PokeInfoView {
        let infoView = PokeInfoView.instantiateFromAppStoryBoard(appStoryBoard: .Info)
        infoView.pkpPokemon = pkpPokemon
        return infoView
    }
    
    deinit {
        debugPrint("💥 Deininting \(Self.self)")
    }
}

// MARK: Helper func's

private extension PokeInfoView {
    
    func configureView() {
        
    }
}
