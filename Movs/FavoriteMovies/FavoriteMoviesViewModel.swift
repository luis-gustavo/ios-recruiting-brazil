//
//  FavoriteMoviesViewModel.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Combine
import Foundation

class FavoriteMoviesViewModel {

    var favoritedMovies = [Movie]()
    private var subscriptions = [AnyCancellable]()

    init() {
        Database
            .shared
            .retrieveData(completion: { result in
            switch result {
            case .failure(let databaseError):
                assertionFailure("Database error, unable to retrieve favorited movies")
                debugPrint(databaseError)
            case .success(let movies):
                self.favoritedMovies = movies
            }
        })
    }

    func poster(posterPath: String, completion: @escaping (Data) -> Void) {
        Network
            .shared
            .getPoster(posterPath: posterPath)
            .sink(receiveCompletion: { completion in
            debugPrint(completion)
            }) { data in
                completion(data)
            }.store(in: &subscriptions)
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
