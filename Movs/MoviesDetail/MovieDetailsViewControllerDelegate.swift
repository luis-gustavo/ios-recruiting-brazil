//
//  MovieDetailsViewControllerDelegate.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

protocol MovieDetailsViewControllerDelegate {
    func dismissDetailsViewController(movie: Movie, favoritedMovies: [Movie])
}
