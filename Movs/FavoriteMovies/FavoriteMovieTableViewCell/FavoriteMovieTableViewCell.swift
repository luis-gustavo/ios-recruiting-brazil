//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView(frame: .zero)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()

    lazy var movieName: UILabel = {
        let movieName = UILabel(frame: .zero)
        movieName.font = UIFont.boldSystemFont(ofSize: movieName.font.pointSize)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()

    lazy var movieYear: UILabel = {
        let movieYear = UILabel(frame: .zero)
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        return movieYear
    }()

    lazy var movieSummary: UILabel = {
        let movieSummary = UILabel(frame: .zero)
        movieSummary.translatesAutoresizingMaskIntoConstraints = false
        movieSummary.numberOfLines = 10
        movieSummary.adjustsFontSizeToFitWidth = true
        return movieSummary
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        return activityIndicator
    }()

    static let cellId = "FavoriteMovieTableViewCell"

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

extension FavoriteMovieTableViewCell: ViewCodable {
    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(movieName)
        addSubview(movieYear)
        addSubview(movieSummary)
        addSubview(activityIndicator)
    }

    func setupConstraints() {

        // Movie image
        movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive
         = true
        movieImage.topAnchor.constraint(equalTo: self.topAnchor).isActive
        = true
        movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive
        = true
        movieImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true

        // Movie year
        movieYear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: frame.size.width * 0.05).isActive = true
        movieYear.heightAnchor.constraint(equalTo: self.movieName.heightAnchor).isActive = true
        movieYear.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        movieYear.centerYAnchor.constraint(equalTo: movieName.centerYAnchor).isActive = true

        // Movie name
        movieName.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.size.height * 0.05).isActive = true
        movieName.leadingAnchor.constraint(equalTo: self.movieImage.trailingAnchor, constant: frame.size.width * 0.05).isActive = true
        movieName.trailingAnchor.constraint(equalTo: self.movieYear.leadingAnchor, constant: -frame.size.width * 0.05).isActive = true
        movieName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true

        // Movie summary
        movieSummary.leadingAnchor.constraint(equalTo: self.movieImage.trailingAnchor, constant: frame.size.width * 0.05).isActive = true
        movieSummary.topAnchor.constraint(equalTo: self.movieName.bottomAnchor, constant: frame.size.height * 0.05).isActive = true
        movieSummary.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -frame.size.height * 0.05).isActive = true
        movieSummary.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Activity indicator
        activityIndicator.centerXAnchor.constraint(equalTo: self.movieImage.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.movieImage.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
    }

    func setupAdditionalConfiguration() {
        activityIndicator.isHidden = true
        backgroundColor = Colors.customDarkBlue
        movieName.textColor = Colors.customYellow
        movieYear.textColor = Colors.customYellow
        movieSummary.textColor = Colors.customYellow
    }

}
