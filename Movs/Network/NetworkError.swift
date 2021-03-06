//
//  NetworkError.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case networkError(Error)
    case withoutResponse
    case decodingError(Error)
}
