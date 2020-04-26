//
//  MoviesListViewControllerDelegate.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

protocol MoviesListViewControllerDelegate {
    func showDetail(for movie: Movie, with poster: UIImage?, favoritedMovies: [Movie])
}
