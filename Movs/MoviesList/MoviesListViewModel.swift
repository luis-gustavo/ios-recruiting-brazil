//
//  MoviesListViewModel.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import Combine

class MoviesListViewModel {

    private var subscriptions = [AnyCancellable]()
    var favoritedMovies = [Movie]()

    init() {
        Database.shared.retrieveData(completion: { result in
            switch result {
            case .failure(let databaseError):
                assertionFailure("Database error, unable to retrieve favorited movies")
                debugPrint(databaseError)
            case .success(let movies):
                self.favoritedMovies = movies
            }
        })
    }

    func popularMovies(completion: @escaping ([Movie]) -> Void) {
        Network
            .shared
            .getPopularMovies(page: PageSingleton.shared.page)
            .sink(receiveCompletion: { (completion) in
                debugPrint(completion)
            }, receiveValue: { networkResponse in
                completion(networkResponse.results)
            }).store(in: &subscriptions)
    }

    func poster(posterPath: String, completion: @escaping (Data) -> Void) {
        Network.shared.getPoster(posterPath: posterPath).sink(receiveCompletion: { completion in
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
