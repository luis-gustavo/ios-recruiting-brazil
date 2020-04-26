//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Properties
    lazy var screen = MovieDetailViewControllerScreen(frame: view.bounds)
    let movie: Movie
    let poster: UIImage?
    let viewModel: MovieDetailViewModel
    var delegate: MovieDetailsViewControllerDelegate?

    // MARK: - Inits
    init(movie: Movie, poster: UIImage?, favoritedMovies: [Movie]) {
        self.movie = movie
        self.poster = poster
        self.viewModel = MovieDetailViewModel(favoritedMovies: favoritedMovies)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    // MARK: - ViewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            delegate?.dismissDetailsViewController(movie: movie, favoritedMovies: viewModel.favoritedMovies)
        }
    }
}

extension MovieDetailsViewController {
    func setup() {
        setupMovieNameLabel()
        setupMovieImage()
        setupMovieYear()
        setupMovieSummary()
        setupGenres()
        setupNavigationController()
        setupFavoriteButton()
    }

    func setupMovieNameLabel() {
        screen.nameLabel.text = movie.title
    }

    func setupMovieImage() {
        screen.movieImage.image = poster
    }

    func setupMovieYear() {
        screen.yearLabel.text = "\(movie.releaseYear)"
    }

    func setupMovieSummary() {
        screen.summaryLabel.text = movie.overview
    }

    func setupGenres() {
        viewModel.genres { genres in
            let containedGenres = genres.filter({ self.movie.genreIds.contains($0.id) }).map({ $0.name })
            DispatchQueue.main.async {
                self.screen.genreLabel.text = containedGenres.joined(separator: ", ")
            }
        }
    }

    func setupNavigationController() {
        self.title = "\(movie.title)"
    }

    func setupFavoriteButton() {
        screen.favoriteButton.delegate = self
        let favorited = viewModel.favoritedMovies.contains(where: { $0.id == movie.id })
        screen.favoriteButton.favoriteState = favorited ? .favorited : .unfavorited
    }
}

extension MovieDetailsViewController: FavoriteButtonDelegate {
    func button(_ sender: FavoriteButton, with tag: Int) {

        viewModel.favoriteMovie(movie) {
            let favorited = self.viewModel.favoritedMovies.contains(where: { $0.id == self.movie.id })
            self.screen.favoriteButton.favoriteState = favorited ? .favorited : .unfavorited
        }
    }
}
