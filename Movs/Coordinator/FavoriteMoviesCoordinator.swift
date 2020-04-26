//
//  FavoriteMoviesCoordinator.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

protocol FavoriteMoviesCoordinatorDelegate {
    func dismissedFavoriteMoviesViewController(favoritedMovies: [Movie])
}

class FavoriteMoviesCoordinator: Coordinatable {

    let navigationController: UINavigationController
    var delegate: FavoriteMoviesCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoriteMoviesViewController = FavoriteMoviesViewController()
        favoriteMoviesViewController.delegate = self
        navigationController.pushViewController(favoriteMoviesViewController, animated: true)
    }
}

extension FavoriteMoviesCoordinator: FavoriteMoviesViewControllerDelegate {
    func dismissFavoriteMoviesViewController(favoritedMovies: [Movie]) {
        delegate?.dismissedFavoriteMoviesViewController(favoritedMovies: favoritedMovies)
    }
}


