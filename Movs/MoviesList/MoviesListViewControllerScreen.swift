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
        let textField = UISearchBar(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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

    // MARK: - Inits
    override init(frame: CGRect) {
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
        searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.size.height * 0.05).isActive = true
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

    }

}
