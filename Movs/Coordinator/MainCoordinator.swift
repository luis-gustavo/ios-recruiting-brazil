//
//  MainCoordinator.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinatable {

    let tabBarController: UITabBarController
    var children = [Coordinatable]()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        setupTabBar()
    }

    fileprivate func setupTabBar() {
        self.tabBarController.tabBar.isTranslucent = false
        self.tabBarController.tabBar.barTintColor = Colors.customYellow
        self.tabBarController.tabBar.tintColor = Colors.customDarkBlue
    }

    func start() {

        // Movies list
        let moviesListNavigationController = UINavigationController()
        let moviesListCoordinator = MoviesListCoordinator(navigationController: moviesListNavigationController)
        children.append(moviesListCoordinator)

        // Favorite movies
        let favoriteMoviesNavigationController = UINavigationController()
        let favoriteMoviesCoordinator = FavoriteMoviesCoordinator(navigationController: favoriteMoviesNavigationController)
        children.append(favoriteMoviesCoordinator)

        children.forEach({ $0.start() })

        tabBarController.setViewControllers([moviesListNavigationController, favoriteMoviesNavigationController], animated: true)

        moviesListNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_tabbar")!, tag: 0)

        favoriteMoviesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_tabbar")!, tag: 1)
    }
}

