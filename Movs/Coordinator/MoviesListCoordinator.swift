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
    func showDetail(for movie: Movie, with poster: UIImage?, favoritedMovies: [Movie]) {

        let movieDetailViewController = MovieDetailsViewController(movie: movie, poster: poster, favoritedMovies: favoritedMovies)
        movieDetailViewController.delegate = self
        movieDetailViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }

}

extension MoviesListCoordinator: MovieDetailsViewControllerDelegate {
    func dismissDetailsViewController(movie: Movie, favoritedMovies: [Movie]) {
        if let moviesViewViewController = navigationController.viewControllers.first.map({ $0 as? MoviesListViewController }) {

            moviesViewViewController?.viewModel.favoritedMovies = favoritedMovies
            moviesViewViewController?.screen.collectionView.reloadData()
        }
    }

}
