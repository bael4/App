//
//  BaseImageView.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

final class BaseImageView: UIImageView {

    let layoutSetup = AppConfigs.LayoutSettings.self

    init() {
        super.init(frame: .zero)
        layer.cornerRadius = layoutSetup.borderRadius
        contentMode = .scaleToFill
        clipsToBounds = true
        layer.masksToBounds = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
