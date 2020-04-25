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
    }

    func start() {
        let moviesViewViewController = MoviesListViewController()
        navigationController.pushViewController(moviesViewViewController, animated: true)
        moviesViewViewController.delegate = self
    }
}

extension MoviesListCoordinator: MoviesListViewControllerDelegate {
    func showDetail(for movie: Movie, with poster: UIImage?) {
        let movieDetailsViewController = MovieDetailsViewController(movie: movie, poster: poster)
        movieDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
