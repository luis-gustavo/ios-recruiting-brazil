//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView(frame: .zero)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()

    lazy var movieName: UILabel = {
        let movieName = UILabel(frame: .zero)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()

    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton(frame: .zero)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favoriteButton
    }()

    static let cellId = "MovieCollectionViewCell"

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoviesCollectionViewCell: ViewCodable {

    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(movieName)
        addSubview(favoriteButton)
    }

    func setupConstraints() {

        // Movie image
        movieImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        movieImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        // Movie name
        movieName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        movieName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        movieName.topAnchor.constraint(equalTo: self.movieImage.bottomAnchor, constant: self.frame.size.height * 0.05).isActive = true
        movieName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        // Favorite button
        favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.size.width * 0.05).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: movieName.centerYAnchor).isActive = true

    }

    func setupAdditionalConfiguration() {
        backgroundColor = Colors.customGrey
        movieName.textColor = Colors.customYellow
    }
}