//
//  UIView+Extension.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

}
