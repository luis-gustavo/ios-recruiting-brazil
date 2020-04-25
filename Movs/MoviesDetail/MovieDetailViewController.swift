//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    lazy var screen = MovieDetailViewControllerScreen(frame: view.bounds)

    override func loadView() {
        super.loadView()

        view = screen
    }
}
