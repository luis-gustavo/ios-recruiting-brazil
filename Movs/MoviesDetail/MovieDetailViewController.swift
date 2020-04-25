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
    let viewModel = MovieDetailViewModel()

    // MARK: - Inits
    init(movie: Movie, poster: UIImage?) {
        self.movie = movie
        self.poster = poster
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
}

extension MovieDetailsViewController {
    func setup() {
        setupMovieNameLabel()
        setupMovieImage()
        setupMovieYear()
        setupMovieSummary()
        setupGenres()
        setupNavigationController()
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
}
