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
}

extension FavoriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.cellId, for: indexPath) as? FavoriteMovieTableViewCell else {

            fatalError("Cell must be of type: \(type(of: FavoriteMovieTableViewCell.self))")
        }

        return cell
    }


}
