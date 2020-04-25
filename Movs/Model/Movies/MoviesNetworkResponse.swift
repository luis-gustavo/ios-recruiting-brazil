//
//  NetworkResponse.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class MoviesNetworkResponse: Decodable {
    let page: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try container.decode(Int.self, forKey: .page)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}
