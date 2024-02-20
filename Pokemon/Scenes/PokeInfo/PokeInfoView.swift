//
//  PokeInfoView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit
import SDWebImage

class PokeInfoView: UIViewController {
    
    @IBOutlet private weak var loader: CustomActivityIndicator!
    @IBOutlet private weak var ringedCircularView: RingedCircleView!
    @IBOutlet private weak var pokemonName: UILabel!
    @IBOutlet private weak var pokemonImage: PokemonImageView!
    @IBOutlet private weak var pokemonSmallDescription: UILabel!
    @IBOutlet private weak var latestPokemonCryBtn: OGGButton!
    @IBOutlet private weak var legacyPokemonCryBtn: OGGButton!
    
    private var pokeInfoModel: PokeInfoModel!
    
    private lazy var pokemonCry: PokeCryManager = { PokeCryManager() }()
    
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
        if self.isMovingFromParent {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    class func create(with pkpPokemon: PKPPokemon) -> PokeInfoView {
        let infoView = PokeInfoView.instantiateFromAppStoryBoard(appStoryBoard: .Info)
        infoView.pkpPokemon = pkpPokemon
        return infoView
    }
    
    @IBAction private func onTapCry(_ sender: OGGButton) {
        if sender === latestPokemonCryBtn {
            pokemonCry.play(with: pokeInfoModel.pokePedia?.cries?.latest.asURL)
        } else {
            pokemonCry.play(with: pokeInfoModel.pokePedia?.cries?.legacy.asURL)
        }
    }
    
    deinit {
        debugPrint("💥 Deininting \(Self.self)")
    }
}

// MARK: Helper func's

private extension PokeInfoView {
    
/// Configures the view by setting up the PokeInfoModel, loading the Pokemon image, setting the title, and handling different states of the PokeInfoModel.
    func configureView() {
        let customBackButton = UIBarButtonItem(image: UIImage(.left)?.withConfiguration(.backConfig), style: .plain, target: self, action: #selector(backAction(sender:)))
        customBackButton.tintColor = .oppositeAccent
        navigationItem.leftBarButtonItem = customBackButton
        let pokeInfoModel = PokeInfoModel(pkpPokemon: pkpPokemon)
        self.title = pkpPokemon?.hashedID
        pokemonName.textColor = .oppositeAccent
        pokemonName.setText(pkpPokemon?.name)
        pokemonSmallDescription.textColor = .accent
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
    
    /// Updates the view after successfully retrieving Pokemon information by hiding the loader and setting the Pokemon name.
    func onSuccessOfGettingInfo() {
        self.showLoader = false
        guard let pokePedia = pokeInfoModel.pokePedia else { return }
        if self.title == nil {
            self.title = String(pokePedia.id).hashedString
        }
        latestPokemonCryBtn.isEnabled = pokePedia.cries?.latest.asURL != nil
        legacyPokemonCryBtn.isEnabled = pokePedia.cries?.legacy.asURL != nil
        self.pokemonImage.loadFrom(from: pokePedia.sprites?.frontLoadPreferSVGImage?.url) { [weak self] in
            self?.pokemonImage.loadFrom(from: pokePedia.sprites?.frontLoadImage?.url)
        }
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        // custom actions here
        navigationController?.popViewController(animated: true)
    }
}

