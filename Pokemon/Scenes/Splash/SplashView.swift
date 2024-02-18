//
//  SplashView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//
    
import UIKit

final class SplashView: UIViewController {
    
    @IBOutlet private weak var loader: CustomActivityIndicator!
    @IBOutlet private weak var gifImageView: UIImageView!
    
    private let model: SplashModel = SplashModel()
    
    private var showLoader: Bool = false {
        didSet {
            showLoader ? loader.startAnimating() : loader.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    deinit {
        debugPrint("💥 Deininting \(Self.self)")
    }
}

// MARK: Helper func's

private extension SplashView {
    
    func configureView() {
        let jeremyGif = UIImage.gifImageWithName("pokeball")
        self.gifImageView.image = jeremyGif
        model.onStateChange = { [weak self] state in
            guard let self else { return }
            assert(Thread.isMainThread)
            switch state {
            case .loading:
                showLoader = true
            case .success:
                showLoader = false
                let navWithRoot = UINavigationController(rootViewController: RootView.createRoot())
                navWithRoot.isNavigationBarHidden = true
                AppDelegate.makeRootViewController(navWithRoot)
            case .failure(let error):
                showLoader = false
                showAlert(title: error, positiveTapWithTitle: ("Reload" ,{ [weak self] in
                    guard let self else { return }
                    self.model.getEndPoints()
                }))
            }
        }
        model.getEndPoints()
    }
}
