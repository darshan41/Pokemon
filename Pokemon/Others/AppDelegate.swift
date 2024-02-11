//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit
import CoreData

var appDelegate: AppDelegate { UIApplication.shared.delegate as! AppDelegate }

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var orientationLock: UIInterfaceOrientationMask = .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initaialSetup()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            appDelegate.orientationLock = orientation
        }
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
        
        static func shouldLockToPortrait() {
            lockOrientation(.portrait, andRotateTo: .portrait)
        }
        
        static func shouldLockToLandscape() {
            lockOrientation(.landscape, andRotateTo: .unknown)
        }
    }
    
    static func makeRootViewController(_ viewController: UIViewController,_ animated: Bool = true) {
        guard let window = appDelegate.window else { return }
        guard animated else {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
    
    func initaialSetup() {
        let _ = Pokemon.shared
    }
}
