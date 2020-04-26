//
//  FavoriteButtonDelegate.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

protocol FavoriteButtonDelegate {
    func button(_ sender: FavoriteButton, didChangeToState state: FavoriteButton.FavoriteState)
}
