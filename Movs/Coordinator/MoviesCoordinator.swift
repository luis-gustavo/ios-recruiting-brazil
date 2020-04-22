//
//  MoviesCoordinator.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MoviesCoordinator: Coordinatable {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let moviesViewController = MoviesViewController()
        navigationController.pushViewController(moviesViewController, animated: true)
    }
}
