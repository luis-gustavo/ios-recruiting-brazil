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
    lazy var screen = MoviesListViewControllerSreen(frame: view.bounds)
    var subscriptions = [AnyCancellable]()
    let cellId = "cell"

    // MARK: - LoadView
    override func loadView() {
        super.loadView()

        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        Network.shared.getPopularMovies().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let networkError):
                switch networkError {
                case .withoutResponse: print("without response")
                case .networkError(let error ): print("network error: \(error.localizedDescription)")
                case .decodingError(let error ): print("decoding error: \(error.localizedDescription)")
                }
            case .finished: print("finished")
            }
        }) { networkResponse in
            print(networkResponse.results.forEach({ print($0) }))
        }.store(in: &subscriptions)

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

extension MoviesListViewController: UICollectionViewDelegate { }

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfCellsPerRow = 2

        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {

            assertionFailure("CollectionViewFlowLayout must be of type: \(type(of: UICollectionViewFlowLayout.self))")
            return .zero
        }

        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsPerRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsPerRow))


        return CGSize(width: size, height: size)
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.cellId, for: indexPath) as? MoviesCollectionViewCell else {

            assertionFailure("Cell must be of the type: \(type(of: MoviesCollectionViewCell.self))")
            return UICollectionViewCell()
        }

        cell.movieName.text = "THOR"

        return cell
    }


}
