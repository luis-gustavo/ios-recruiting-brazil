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
        movieImage.image = UIImage(named: "SplashScreen")
        return movieImage
    }()

    lazy var movieName: UILabel = {
        let movieName = UILabel(frame: .zero)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.textAlignment = .center
        movieName.numberOfLines = 5
        return movieName
    }()

    lazy var favoriteButton: FavoriteButton = {
        let favoriteButton = FavoriteButton(frame: .zero)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favoriteButton
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
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

    func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

}

extension MoviesCollectionViewCell: ViewCodable {

    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(movieName)
        addSubview(favoriteButton)
        addSubview(activityIndicator)
    }

    func setupConstraints() {

        // Movie image
        movieImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        movieImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        movieImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        // Movie name
        movieName.topAnchor.constraint(equalTo: self.movieImage.bottomAnchor).isActive = true
        movieName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        movieName.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true

        // Favorite button
        favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.frame.size.width * 0.1).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: movieName.centerYAnchor).isActive = true

        // Continue movie name
        movieName.trailingAnchor.constraint(equalTo: self.favoriteButton.leadingAnchor).isActive = true

        // Activity Indicator
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
    }

    func setupAdditionalConfiguration() {
        backgroundColor = Colors.customDarkBlue
        movieName.textColor = Colors.customYellow
        activityIndicator.isHidden = true
    }
}
