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
                print(movies)
                self.favoritedMovies = movies
            }
        })
    }

    func popularMovies(completion: @escaping ([Movie]) -> Void) {
        Network
            .shared
            .getPopularMovies()
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

    func favoriteMovie(_ movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        favoritedMovies.append(movie)
        Database.shared.saveData(favoritedMovies, completion: completion)
    }

}
