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
    }

    func start() {
        let moviesNavigationController = UINavigationController()
        moviesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let moviesCoordinator = MoviesCoordinator(navigationController: moviesNavigationController)
        children.append(moviesCoordinator)

        children.forEach({ $0.start() })

        tabBarController.setViewControllers([moviesNavigationController], animated: true)
    }
}

