//
//  GenreSingleton.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Combine

class GenreSingleton {

    private var subscriptions = [AnyCancellable]()

    private init() {
        requestGenre(completion: { _ in })
    }

    func requestGenre(completion: @escaping ([Genre]) -> Void) {
        Network
        .shared
        .requestGenre().sink(receiveCompletion: { completion in
            debugPrint(completion)
        }) { networkResponse in
            self._genres = networkResponse.results
            completion(networkResponse.results)
        }.store(in: &subscriptions)
    }

    static let shared = GenreSingleton()

    private var _genres = [Genre]()
    var genres: [Genre] {
        return _genres
    }

}
