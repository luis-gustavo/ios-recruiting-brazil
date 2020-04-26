//
//  FavoriteButton.swift
//  Movs
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/04/20.
//  Copyright © 2020 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {

    enum FavoriteState {
        case favorited
        case unfavorited
    }

    // MARK: - Properties
    let favoriteEmptyImage = UIImage(named: "favorite_empty")!
    let favoriteFilledImage = UIImage(named: "favorite_filled")!
    var favoriteState = FavoriteState.unfavorited {
        didSet {
            didChange(to: favoriteState)
        }
    }
    var delegate: FavoriteButtonDelegate?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)

        setImage(favoriteEmptyImage, for: .normal)
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Deinit
    deinit {
        removeTarget(self, action: nil, for: .touchUpInside)
    }

    // MARK: - Methods
    @objc private func buttonClicked() {
        delegate?.button(self, with: tag)
    }

    private func didChange(to state: FavoriteButton.FavoriteState) {
        switch state {
        case .favorited:
            setImage(favoriteFilledImage, for: .normal)
        case .unfavorited:
            setImage(favoriteEmptyImage, for: .normal)
        }
    }

}

