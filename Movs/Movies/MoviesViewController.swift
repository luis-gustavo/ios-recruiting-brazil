//
//  MoviesViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    // MARK: - Constants
    let viewModel = MoviesViewModel()
    lazy var screen = MoviesViewControllerSreen(frame: view.bounds)
    var subscriptions = [AnyCancellable]()

    // MARK: - LoadView
    override func loadView() {
        super.loadView()

        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
            //movies.forEach({ print($0) })
            print(networkResponse.results.forEach({ print($0) }))
        }.store(in: &subscriptions)

    }
}
