//
//  MoviesViewController.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Constants
    let viewModel = MoviesViewModel()
    lazy var screen = MoviesViewControllerSreen(frame: view.bounds)

    // MARK: - LoadView
    override func loadView() {
        super.loadView()

        self.view = screen
    }
}
