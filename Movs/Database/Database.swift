//
//  Database.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class Database {

    private init() { }

    static let shared = Database()

    private let key = "br.com.bepiducb.Mov.Database"

    func saveData(_ movies: [Movie], completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: key)
            completion(.success(()))
        } catch let error {
            completion(.failure(.encodingError(error)))
        }
    }

    func retrieveData(completion: @escaping (Result<[Movie], DatabaseError>) -> Void) {

        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                completion(.failure(.emptyResult))
                return
            }
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            completion(.success(movies))
        } catch let error {
            completion(.failure(.decodingError(error)))
        }
    }

}
