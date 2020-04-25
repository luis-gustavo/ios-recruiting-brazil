//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class MovieDetailViewModel {

    func genres(completion: @escaping ([Genre]) -> Void) {
        if GenreSingleton.shared.genres.isEmpty {
            GenreSingleton.shared.requestGenre { genres in
                completion(genres)
            }
        } else {
            completion(GenreSingleton.shared.genres)
        }
    }
}
