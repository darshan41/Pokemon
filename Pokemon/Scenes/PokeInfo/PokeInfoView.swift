//
//  PokeInfoView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit
import SwiftUI

class PokeInfoView: UIViewController {
    
    @IBOutlet private weak var loader: CustomActivityIndicator!
    @IBOutlet private weak var ringedCircularView: RingedCircleView!
    @IBOutlet private weak var pokemonName: UILabel!
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var pokemonSmallDescription: UILabel!
    
    private var pokeInfoModel: PokeInfoModel!
    private weak var pkpPokemon: PKPPokemon?
    
    private var showLoader: Bool = false {
        didSet {
            showLoader ? loader.startAnimating() : loader.stopAnimating()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
        let pokeInfoModel = PokeInfoModel(pkpPokemon: pkpPokemon)
        self.title = pkpPokemon?.hashedID
        pokemonName.textColor = .oppositeAccent
        pokemonSmallDescription.textColor = .oppositeAccent
        self.pokeInfoModel = pokeInfoModel
        pokeInfoModel.onStateChange = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                self.showLoader = true
            case .success:
                self.onSuccessOfGettingInfo()
            case .failure(let error):
                showAlert(title: error, positiveTapWithTitle: ("Reload", { [weak self] in
                    guard let self else { return }
                    self.pokeInfoModel.getInformation()
                }), negativeTapWithTitle: ("Go Back", { [weak self] in
                    guard let self else { return }
                    self.navigationController?.popViewController(animated: true)
                }), positiveButtonStyle: .default, negativeButtonStyle: .default)
            }
        }
        pokeInfoModel.getInformation()
    }
    
    func onSuccessOfGettingInfo() {
        self.showLoader = false
        pokemonName.setText(pkpPokemon?.name)
    }
}
