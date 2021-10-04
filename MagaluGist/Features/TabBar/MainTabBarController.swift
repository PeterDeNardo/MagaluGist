//
//  MainTabBarController.swift
//  MagaluGist
//
//  Created by Peter De Nardo on 03/10/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentSetup()
    }
    
    private func contentSetup() {
        let dashViewController = DashViewController()
        let favoritesController = FavoritesViewController()
        let tabItemOne = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        let tabItemTwo = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        dashViewController.tabBarItem = tabItemOne
        favoritesController.tabBarItem = tabItemTwo
        
        let controllers = [dashViewController, favoritesController]
        self.viewControllers = controllers
    }

}
