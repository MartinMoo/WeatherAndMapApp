//
//  TabBarController.swift
//  WeatherAndMapApp
//
//  Created by Moo Maa on 14/05/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()


    }
    
    //MARK: - UI methods
    private func setupUI() {
        // View Controllers
        let mapViewController = MapViewController()
        let searchViewController = SearchViewController()
        let favoritesViewController = FavoritesViewController()
        
        // Nav Controllers
        let navMapController = UINavigationController()
        let navSearchController = UINavigationController()
        let navFavoritesController = UINavigationController()
        
        navMapController.viewControllers = [mapViewController]
        navSearchController.viewControllers = [searchViewController]
        navFavoritesController.viewControllers = [favoritesViewController]
        
        // Tab Bar Icons setup
        let mapSymbol = UIImage(systemName: "map")?.withTintColor(UIColor.Custom.gray!, renderingMode: .alwaysOriginal)
        let searchSymbol = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor.Custom.gray!, renderingMode: .alwaysOriginal)
        let starSymbol = UIImage(systemName: "star")?.withTintColor(UIColor.Custom.gray!, renderingMode: .alwaysOriginal)
        
        // TabBar Style setup
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Custom.gray!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.Custom.purple!], for: .selected)
        
        // NavBar Style setup
        let backSymbol = UIImage(systemName: "arrow.left.circle.fill")?.withTintColor(UIColor.Custom.purple!, renderingMode: .alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backSymbol
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backSymbol
        UINavigationBar.appearance().backgroundColor = .systemBackground
        UINavigationBar.appearance().prefersLargeTitles = true
        
        // TabBar items/buttons setup
        navMapController.tabBarItem = UITabBarItem(title: "Map", image: mapSymbol, selectedImage: mapSymbol?.withTintColor(UIColor.Custom.purple!))
        navSearchController.tabBarItem = UITabBarItem(title: "Search", image: searchSymbol, selectedImage: searchSymbol?.withTintColor(UIColor.Custom.purple!))
        navFavoritesController.tabBarItem = UITabBarItem(title: "Favorites", image: starSymbol, selectedImage: starSymbol?.withTintColor(UIColor.Custom.purple!))

        // Add items to TabBar
        let tabBarList = [navMapController,navSearchController,navFavoritesController]
        self.setViewControllers(tabBarList, animated: false)
    }


}
