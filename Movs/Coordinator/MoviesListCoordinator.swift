//
//  MoviesCoordinator.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MoviesListCoordinator: Coordinatable {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationController()
    }

    func start() {
        let moviesViewController = MoviesListViewController()
        navigationController.pushViewController(moviesViewController, animated: true)
    }

    fileprivate func setupNavigationController() {
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.barTintColor = Colors.customYellow
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.layoutIfNeeded()
        self.navigationController.title = "Movies"
    }
}
