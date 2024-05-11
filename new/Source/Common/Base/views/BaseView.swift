//
//  BaseView.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

class BaseView: UIView {
    
    let layoutSetup = AppConfigs.LayoutSettings.self
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onAddSubviews()
        onConfigureView()
        onSetupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onConfigureView() {
        layer.cornerRadius = layoutSetup.borderRadius
        layer.borderWidth = 4
        layer.borderColor = UIColor.whiteBorder.cgColor
        layer.shadowColor = UIColor.blackShadow.cgColor
        layer.shadowOpacity = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }

    func onAddSubviews() {}

    func onSetupConstraints() {}

}
