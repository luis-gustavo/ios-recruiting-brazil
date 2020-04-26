//
//  MovieDetailViewControllerScreen.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MovieDetailViewControllerScreen: UIView {

    // MARK: - Properties
    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView(frame: .zero)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()

    lazy var favoriteButton: FavoriteButton = {
        let favoriteButton = FavoriteButton(frame: .zero)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favoriteButton
    }()

    lazy var divisorView1: UIView = {
        let divisorView = UIView(frame: .zero)
        divisorView.translatesAutoresizingMaskIntoConstraints = false
        divisorView.backgroundColor = Colors.customSilver
        return divisorView
    }()

    lazy var yearLabel: UILabel = {
        let yearLabel = UILabel(frame: .zero)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        return yearLabel
    }()

    lazy var divisorView2: UIView = {
        let divisorView = UIView(frame: .zero)
        divisorView.translatesAutoresizingMaskIntoConstraints = false
        divisorView.backgroundColor = Colors.customSilver
        return divisorView
    }()

    lazy var genreLabel: UILabel = {
        let genreLabel = UILabel(frame: .zero)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        return genreLabel
    }()

    lazy var divisorView3: UIView = {
        let divisorView = UIView(frame: .zero)
        divisorView.translatesAutoresizingMaskIntoConstraints = false
        divisorView.backgroundColor = Colors.customSilver
        return divisorView
    }()

    lazy var summaryLabel: UILabel = {
        let summaryLabel = UILabel(frame: .zero)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.numberOfLines = 10
        summaryLabel.adjustsFontSizeToFitWidth = true
        return summaryLabel
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

extension MovieDetailViewControllerScreen: ViewCodable {
    func buildViewHierarchy() {
        addSubview(movieImage)
        addSubview(nameLabel)
        addSubview(favoriteButton)
        addSubview(divisorView1)
        addSubview(yearLabel)
        addSubview(divisorView2)
        addSubview(genreLabel)
        addSubview(divisorView3)
        addSubview(summaryLabel)
    }

    func setupConstraints() {
        // Movie image
        movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.size.height * 0.02).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: frame.size.width * -0.05).isActive = true
        movieImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true

        // Favorite button
        favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true

        // Name label
        nameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: frame.size.height * 0.02).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -frame.size.width * 0.05).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

        // Divisor 1
        divisorView1.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.001).isActive = true
        divisorView1.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        divisorView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        divisorView1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Year label
        yearLabel.topAnchor.constraint(equalTo: self.divisorView1.bottomAnchor, constant: frame.size.height * 0.02).isActive = true
        yearLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Divisor 2
        divisorView2.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.001).isActive = true
        divisorView2.topAnchor.constraint(equalTo: self.yearLabel.bottomAnchor).isActive = true
        divisorView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        divisorView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Genre label
        genreLabel.topAnchor.constraint(equalTo: self.divisorView2.bottomAnchor, constant: frame.size.height * 0.02).isActive = true
        genreLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Divisor 3
        divisorView3.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.001).isActive = true
        divisorView3.topAnchor.constraint(equalTo: self.genreLabel.bottomAnchor).isActive = true
        divisorView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        divisorView3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.05).isActive = true

        // Summary label
        summaryLabel.topAnchor.constraint(equalTo: self.divisorView3.bottomAnchor, constant: frame.size.height * 0.02).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.frame.size.height * 0.05).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: frame.size.width * 0.05).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -frame.size.width * 0.02).isActive = true
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
