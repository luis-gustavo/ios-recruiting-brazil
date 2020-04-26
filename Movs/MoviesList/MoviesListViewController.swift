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
    var viewModel = MoviesListViewModel()
    lazy var screen = MoviesListViewControllerSreen(frame: view.bounds, navigationController: self.navigationController)
    var delegate: MoviesListViewControllerDelegate?
    var movieImages = [Int: UIImage?]()
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()

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

    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        screen.addGestureRecognizer(tapGesture)
    }

    // MARK: - ViewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        screen.removeGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        screen.endEditing(true)
    }

    func fetchPopularMovies() {
        viewModel.popularMovies { movies in
            self.movies = self.movies + movies
            self.filteredMovies = self.movies
            DispatchQueue.main.async {
                self.screen.collectionView.reloadData()
            }
        }
    }
}

extension MoviesListViewController {
    func setup() {
        setupCollectionView()
        setupSearchBar()
    }

    func setupCollectionView() {
        screen.collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.cellId)
        screen.collectionView.delegate = self
        screen.collectionView.dataSource = self
    }

    func setupSearchBar() {
        screen.searchBar.delegate = self
    }
}

extension MoviesListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let movie = filteredMovies[indexPath.row]
        let poster = movieImages[movie.id] ?? nil

        delegate?.showDetail(for: movie, with: poster, favoritedMovies: viewModel.favoritedMovies)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if bottomEdge >= scrollView.contentSize.height {
            PageSingleton.shared.page += 1
            self.fetchPopularMovies()
        }
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
        return filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.cellId, for: indexPath) as? MoviesCollectionViewCell else {

            assertionFailure("Cell must be of the type: \(type(of: MoviesCollectionViewCell.self))")
            return UICollectionViewCell()
        }

        let movie = filteredMovies[indexPath.row]

        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.delegate = self
        let favorited = viewModel.favoritedMovies.contains(where: { $0.id == movie.id })
        cell.favoriteButton.favoriteState = favorited ? .favorited : .unfavorited

        cell.movieName.text = movie.title

        if let image = movieImages[movie.id] {
            cell.hideActivityIndicator()
            cell.movieImage.image = image
        } else {
            cell.movieImage.image = nil
            cell.showActivityIndicator()
            DispatchQueue.global().async {
                self.viewModel.poster(posterPath: movie.posterPath) { data in
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.movieImages[movie.id] = image
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

        let movie = filteredMovies[tag]
        viewModel.favoriteMovie(movie) {
            self.screen.collectionView.reloadData()
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = movies

        if !searchText.isEmpty {
            filteredMovies = movies.filter({ $0.title.contains(searchText) })
        }

        screen.collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
