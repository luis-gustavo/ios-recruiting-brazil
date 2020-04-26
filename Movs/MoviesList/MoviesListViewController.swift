//
//  MoviesListViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import Combine

class MoviesListViewController: UIViewController {

    // MARK: - Constants
    let viewModel = MoviesListViewModel()
    lazy var screen = MoviesListViewControllerSreen(frame: view.bounds, navigationController: self.navigationController)
    var delegate: MoviesListViewControllerDelegate?
    var movieImages = [Int: UIImage?]()
    var movies = [Movie]()

    // MARK: - LoadView
    override func loadView() {
        super.loadView()
        self.view = screen
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchPopularMovies()
    }

    func fetchPopularMovies() {
        viewModel.popularMovies { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.screen.collectionView.reloadData()
            }
        }
    }
}

extension MoviesListViewController {
    func setup() {
        setupCollectionView()
    }

    func setupCollectionView() {
        screen.collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.cellId)
        screen.collectionView.delegate = self
        screen.collectionView.dataSource = self
    }
}

extension MoviesListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let movie = movies[indexPath.row]
        let poster = movieImages[indexPath.row] ?? nil

        delegate?.showDetail(for: movie, with: poster, favoritedMovies: viewModel.favoritedMovies)
    }

}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfCellsPerRow = 2

        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {

            assertionFailure("CollectionViewFlowLayout must be of type: \(type(of: UICollectionViewFlowLayout.self))")
            return .zero
        }

        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsPerRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsPerRow))


        return CGSize(width: CGFloat(size), height: screen.frame.size.height * 0.4)
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.cellId, for: indexPath) as? MoviesCollectionViewCell else {

            assertionFailure("Cell must be of the type: \(type(of: MoviesCollectionViewCell.self))")
            return UICollectionViewCell()
        }

        let movie = movies[indexPath.row]

        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.delegate = self
        let favorited = viewModel.favoritedMovies.contains(where: { $0.id == movie.id })
        cell.favoriteButton.favoriteState = favorited ? .favorited : .unfavorited

        cell.movieName.text = movie.title

        if let image = movieImages[indexPath.row] {
            cell.hideActivityIndicator()
            cell.movieImage.image = image
        } else {
            cell.movieImage.image = nil
            cell.showActivityIndicator()
            DispatchQueue.main.async {
                self.viewModel.poster(posterPath: movie.posterPath) { data in
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

extension MoviesListViewController: FavoriteButtonDelegate {
    func button(_ sender: FavoriteButton, with tag: Int) {

        let movie = movies[tag]
        viewModel.favoriteMovie(movie) {
            self.screen.collectionView.reloadData()
        }
    }
}
