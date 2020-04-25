//
//  Genre.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 25/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Genre: Decodable {
    let id: Int
    let name: String
}

extension Genre: CustomStringConvertible {
    var description: String {
        return "Id: \(id) - Name: \(name)"
    }
}
