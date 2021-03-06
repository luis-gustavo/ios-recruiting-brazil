//
//  Movie.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Movie: Codable {

    let title: String
    let posterPath: String
    private let _releaseDate: String
    var releaseYear: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        guard let date = dateFormatter.date(from: _releaseDate) else {
            assertionFailure("Date must exist")
            return -1
        }
        let year = Calendar.current.component(.year, from: date)
        return year
    }
    let genreIds: [Int]
    let overview: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview = "overview"
        case id
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        _releaseDate = try container.decode(String.self, forKey: .releaseDate)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        overview = try container.decode(String.self, forKey: .overview)
        id = try container.decode(Int.self, forKey: .id)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(_releaseDate, forKey: .releaseDate)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encode(overview, forKey: .overview)
        try container.encode(id, forKey: .id)
    }

}

extension Movie: CustomStringConvertible {

    var description: String {
        return "Id: \(id) \nTitle: \(title) \nPoster Path: \(posterPath) \nGenreIds: \(genreIds) \n Release Year: \(releaseYear) \nOverview: \(overview) \n\n\n"
    }
}
