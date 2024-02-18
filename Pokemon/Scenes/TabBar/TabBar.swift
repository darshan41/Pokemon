//
//  TabBar.swift
//  Pokemon
//
//  Created by Darshan S on 12/02/24.
//

import UIKit

enum TabItem: String,CaseIterable {
    
    case home = "Home"
    case search = "Search"
    case others = "Others"
    case settings = "Settings"
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: self.rawValue, image: UIImage(systemName: "person.fill"), tag: 1)
        case .search:
            return UITabBarItem(title: self.rawValue, image: UIImage(systemName: "tv"), tag: 2)
        case .others:
            return UITabBarItem(title: self.rawValue, image: UIImage(systemName: "globe"), tag: 3)
        case .settings:
            return UITabBarItem(title: self.rawValue, image: UIImage(systemName: "gear"), tag: 4)
        }
    }
    
    static func createControllers(_ mainDelegate: MainDelegte) -> [PokemonNavigation] {
        var navigableControllers: [PokemonNavigation] = []
        for tabCase in TabItem.allCases {
            switch tabCase {
            case .home:
                let homeView = PokemonNavigation(rootViewController: HomeView.createModule(mainDelegate), delegate: mainDelegate)
                homeView.tabBarItem = tabCase.tabBarItem
                navigableControllers.append(homeView)
            case .search:
                let homeView = PokemonNavigation(rootViewController: SearchRouter.createModule(), delegate: mainDelegate)
                homeView.tabBarItem = tabCase.tabBarItem
                navigableControllers.append(homeView)
            case .settings:
                let homeView = PokemonNavigation(rootViewController: HomeView.createModule(mainDelegate), delegate: mainDelegate)
                homeView.tabBarItem = tabCase.tabBarItem
                navigableControllers.append(homeView)
            case .others:
                let homeView = PokemonNavigation(rootViewController: HomeView.createModule(mainDelegate), delegate: mainDelegate)
                homeView.tabBarItem = tabCase.tabBarItem
                navigableControllers.append(homeView)
            }
        }
        return navigableControllers
    }
    
}

final class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    static func createTabBar() -> TabBar {
        let tabBar = TabBar()
        tabBar.setViewControllers(TabItem.createControllers(tabBar), animated: true)
        return tabBar
    }
}

extension TabBar: MainDelegte { }

extension TabBar {
    
    func configureView() {
        
    }
}
