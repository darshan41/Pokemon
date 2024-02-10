//
//  UIViewController.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

extension UIViewController {
    
    class var storyboardID: String { "\(self)" }
    
    static func instantiateFromAppStoryBoard(appStoryBoard: AppStoryBoard) -> Self {
        appStoryBoard.viewController(viewControllerClass: self)
    }
    
    @discardableResult
    func hideKeyboardWhenTappedAround() -> UITapGestureRecognizer {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        return tap
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @discardableResult
    func showAlert(
        title: ErrorShowable? = nil,
        message: String? = nil,
        positiveTapWithTitle: (String,(() -> Void)?)? = nil,
        negativeTapWithTitle: (String,(() -> Void)?)? = nil,
        positiveButtonStyle: UIAlertAction.Style? = nil,
        negativeButtonStyle: UIAlertAction.Style? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(title: (title?.showableDescription ?? ""), message: message ?? String.error(.somethingWentWrong), preferredStyle: .alert)
        if let positiveTapWithTitle {
            let positiveAction = UIAlertAction(title: positiveTapWithTitle.0, style: positiveButtonStyle ?? .default) { _ in
                alertController.dismiss(animated: true,completion: positiveTapWithTitle.1)
            }
            alertController.addAction(positiveAction)
        } else {
            let positiveAction = UIAlertAction(title: "Ok", style: .default) { _ in
                alertController.dismiss(animated: true)
            }
            alertController.addAction(positiveAction)
        }
        if let negativeTapWithTitle {
            let negativeAction = UIAlertAction(title: negativeTapWithTitle.0, style: negativeButtonStyle ?? .default) { _ in
                alertController.dismiss(animated: true, completion: negativeTapWithTitle.1)
            }
            alertController.addAction(negativeAction)
        }
        self.present(alertController, animated: true)
        return alertController
    }
    
    func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? appDelegate.window?.rootViewController
        if let navigationController = base as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabViewController = base as? UITabBarController {
            let addedNavigationController = tabViewController.moreNavigationController
            if let top = addedNavigationController.topViewController,
               top.view.window != nil {
                return topViewController(top)
            } else if let selected = tabViewController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        (UIApplication.shared.delegate as? AppDelegate)?.orientationLock = orientation
    }
    
    func shouldLockToPortrait() {
        assert(Thread.isMainThread)
        self.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    func shouldLockToLandscape() {
        assert(Thread.isMainThread)
        self.lockOrientation(.landscape, andRotateTo: .unknown)
    }
    
    func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        if #available(iOS 16, *) {
            DispatchQueue.main.async {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                if let navigationController = self.navigationController {
                    navigationController.setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                    self.setNeedsUpdateOfSupportedInterfaceOrientations()
                }
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientation)) { error
                    in
                    print(error.localizedDescription)
                }
            }
        } else {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
            self.view.reloadInputViews()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func openBrowser(with urlStr: String?) {
        guard let url = urlStr,
              let url = URL(string: addHttpsToURL(url)),
              UIApplication.shared.canOpenURL(url) else {
            showAlert(title: "Unable to open page")
            return
        }
        UIApplication.shared.open(url)
    }
    
    func addHttpsToURL(_ urlString: String) -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = urlString
        return urlComponents.url?.absoluteString ?? urlString
    }
}
