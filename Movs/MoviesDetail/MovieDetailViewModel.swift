//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    var favoritedMovies = [Movie]()

    init(favoritedMovies: [Movie]) {
        self.favoritedMovies = favoritedMovies
    }

    func genres(completion: @escaping ([Genre]) -> Void) {
        if GenreSingleton.shared.genres.isEmpty {
            GenreSingleton.shared.requestGenre { genres in
                completion(genres)
            }
        } else {
            completion(GenreSingleton.shared.genres)
        }
    }

    func favoriteMovie(_ movie: Movie, completion: @escaping () -> Void) {

        let shouldFavorite = favoritedMovies.contains(where: { $0.id == movie.id})

        switch !shouldFavorite {
        case false:
            guard let index = favoritedMovies.firstIndex(where: { $0.id == movie.id }) else {
                fatalError("This index must exist. If it doesn't, the app has an logic problem")
            }
            favoritedMovies.remove(at: index)
        case true:
            favoritedMovies.append(movie)
        }

        Database.shared.saveData(favoritedMovies, completion: { _ in
            completion()
        })
    }
}
