//
//  PageSingleton.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

class PageSingleton {

    private init() {  }

    static let shared = PageSingleton()

    var page = 1
}
