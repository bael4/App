//
//  BaseCVCell.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

class BaseCVCell: UICollectionViewCell {
    
    let layoutSetup = AppConfigs.LayoutSettings.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        onConfigureCell()
        onAddSubViews()
        onSetupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onConfigureCell() {}

    func onAddSubViews() {}
    
    func onSetupConstraints() {}
    
}
