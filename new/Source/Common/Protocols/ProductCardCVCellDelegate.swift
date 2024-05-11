//
//  ProductCardCVCellDelegate.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation

protocol ProductCardCVCellDelegate: AnyObject {
    func didTapFavoriteButton(at id: Int?)
}

protocol VcCardCVCellDelegate: AnyObject {
    func didTapFavoriteButton(at id: LiteCell)
}
