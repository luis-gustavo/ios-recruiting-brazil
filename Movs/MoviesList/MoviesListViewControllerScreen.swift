//
//  MoviesListViewControllerScreen.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MoviesListViewControllerSreen: UIView {

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.isTranslucent = false
        searchBar.barTintColor = Colors.customYellow
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = Colors.customYellow.cgColor

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = Colors.customDarkYellow

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = Colors.customDarkBlue

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : Colors.customDarkBlue])

        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .zero
        layout.minimumInteritemSpacing = frame.size.width * 0.05
        layout.minimumLineSpacing = frame.size.height * 0.05
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

extension MoviesListViewControllerSreen: ViewCodable {

    func buildViewHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }

    func setupConstraints() {

        // Searchbar
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true

        // CollectionView
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: frame.size.height * 0.05).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func setupAdditionalConfiguration() {

        // View
        backgroundColor = .white

        // Collection view
        collectionView.backgroundColor = .white

        // Navigation Controller
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.customYellow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.customDarkBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

}
