//
//  Movie.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Movie: Decodable {

    let title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
    }

}

extension Movie: CustomStringConvertible {

    var description: String {
        return "Title: \(title) - Poster Path: \(posterPath)"
    }
}
