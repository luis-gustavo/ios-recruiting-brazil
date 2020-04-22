//
//  Network.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation
import Combine

class Network {

    private init() { }

    static let shared = Network()

    let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=0d2e6be0621e98b506e2892bcb3a5b16")!

    func getPopularMovies() -> AnyPublisher<NetworkResponse, NetworkError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse.self, decoder: JSONDecoder())
            .mapError({ $0 as? NetworkError ?? NetworkError.decodingError($0) })
            .eraseToAnyPublisher()
    }
}
