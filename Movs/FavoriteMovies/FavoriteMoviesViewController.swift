//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 24/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

    // MARK: - Properties
    lazy var screen = FavoriteMoviesViewControllerScreen(frame: view.bounds, navigationController: navigationController)
    var viewModel = FavoriteMoviesViewModel()
    var movieImages = [Int: UIImage?]()
    var delegate: FavoriteMoviesViewControllerDelegate?

    // MARK: - LoadView
    override func loadView() {
        super.loadView()
        view = screen
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = FavoriteMoviesViewModel()
        screen.tableView.reloadData()
    }

    // MARK: - ViewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.dismissFavoriteMoviesViewController(favoritedMovies: viewModel.favoritedMovies)
    }

}

extension FavoriteMoviesViewController {
    func setup() {
        setupTableView()
    }

    func setupTableView() {
        screen.tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: FavoriteMovieTableViewCell.cellId)
        screen.tableView.delegate = self
        screen.tableView.dataSource = self
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.25
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let movie = viewModel.favoritedMovies[indexPath.row]

        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, completionHandler) in

            self.viewModel.favoriteMovie(movie) {
                tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            }

        }

        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
    }

}

extension FavoriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.favoritedMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.cellId, for: indexPath) as? FavoriteMovieTableViewCell else {

            fatalError("Cell must be of type: \(type(of: FavoriteMovieTableViewCell.self))")
        }

        let favoritedMovie = viewModel.favoritedMovies[indexPath.row]

        cell.movieName.text = favoritedMovie.title
        cell.movieYear.text = "\(favoritedMovie.releaseYear)"
        cell.movieSummary.text = favoritedMovie.overview

        if let image = movieImages[indexPath.row] {
            cell.hideActivityIndicator()
            cell.movieImage.image = image
        } else {
            cell.movieImage.image = nil
            cell.showActivityIndicator()
            DispatchQueue.global().async {
                self.viewModel.poster(posterPath: favoritedMovie.posterPath) { data in
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.movieImages[indexPath.row] = image
                        cell.movieImage.image = image
                        cell.hideActivityIndicator()
                    }
                }
            }
        }

        return cell
    }


}
