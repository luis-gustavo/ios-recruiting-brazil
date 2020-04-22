//
//  MoviesViewControllerScreenSpec.swift
//  MovsTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import XCTest

@testable import Movs

final class MoviesViewControllerScreenSpec: XCTestCase {

    func testScreenBackgroundColor() {
        let screen = MoviesViewControllerSreen(frame: .zero)

        XCTAssertEqual(screen.backgroundColor, .green)
    }
}
