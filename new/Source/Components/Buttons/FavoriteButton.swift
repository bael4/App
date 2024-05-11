//
//  FavoriteButton.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

final class FavoriteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyling()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupStyling() {
        tintColor = .redFill
        sizeToFit()
    }

}

