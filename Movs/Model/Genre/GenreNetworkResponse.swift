//
//  GenreNetworkResponse.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class GenreNetworkResponse: Decodable {
    let results: [Genre]

    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.results = try container.decode([Genre].self, forKey: .genres)
    }

}
