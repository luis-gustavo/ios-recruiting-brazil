//
//  Network.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import Combine

class Network {

    private init() { }

    static let shared = Network()

    private func posterUrl(posterPath: String) -> URL {
        guard let url = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)") else {
            fatalError("URL for poster must exist")
        }
        return url
    }

    private let genreUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=0d2e6be0621e98b506e2892bcb3a5b16&language=en-US")!

    private let popularMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=0d2e6be0621e98b506e2892bcb3a5b16")!

    func getPopularMovies() -> AnyPublisher<MoviesNetworkResponse, NetworkError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: popularMoviesUrl)
            .map(\.data)
            .decode(type: MoviesNetworkResponse.self, decoder: JSONDecoder())
            .mapError({ $0 as? NetworkError ?? NetworkError.decodingError($0) })
            .eraseToAnyPublisher()
    }

    func getPoster(posterPath: String) -> AnyPublisher<Data, NetworkError> {

        return URLSession
            .shared
            .dataTaskPublisher(for: posterUrl(posterPath: posterPath))
            .map(\.data)
            .mapError({ NetworkError.networkError($0) })
            .eraseToAnyPublisher()
    }

    func requestGenre() -> AnyPublisher<GenreNetworkResponse, NetworkError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: genreUrl)
            .map(\.data)
            .decode(type: GenreNetworkResponse.self,
                    decoder: JSONDecoder())
            .mapError({ $0 as? NetworkError ?? NetworkError.decodingError($0) })
            .eraseToAnyPublisher()
    }
}
