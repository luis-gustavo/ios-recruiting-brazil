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

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case overview = "overview"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        _releaseDate = try container.decode(String.self, forKey: .releaseDate)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        overview = try container.decode(String.self, forKey: .overview)
    }

}

extension Movie: CustomStringConvertible {

    var description: String {
        return "Title: \(title) \nPoster Path: \(posterPath) \nGenreIds: \(genreIds) \n Release Year: \(releaseYear) \nOverview: \(overview) \n\n\n"
    }
}
