//
//  FavoriteMoviesViewControllerScreen.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class FavoriteMoviesViewControllerScreen: UIView {

    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let navigationController: UINavigationController?

    // MARK: - Inits
    init(frame: CGRect, navigationController: UINavigationController?) {
        self.navigationController = navigationController
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteMoviesViewControllerScreen: ViewCodable {
    func buildViewHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        // Table view
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func setupAdditionalConfiguration() {
        // Navigation Controller
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.customYellow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.topItem?.title = "Favorite Movies"
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.customDarkBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        // Table view
        tableView.separatorStyle = .none
    }
}
