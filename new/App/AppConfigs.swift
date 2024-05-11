//
//  AppConfigs.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation
import DeviceKit
    
    enum AppConfigs {

        enum CVCell {
            static let cardCVCell = "CardCVCell"
            static let liteCell = "LiteCell"
        }

        enum NetworkURLs {
            static let producntsUrl = "https://fakestoreapi.com/products"
        }

        enum LayoutSettings {
            static var padding: CGFloat { Device.current.isPad ? 40 : 30 }
            static var imageCellPadding : CGFloat { Device.current.isPad ? 50 : 30 }
            static var textCellPadding : CGFloat { Device.current.isPad ? 30 : 20 }
            static var borderRadius : CGFloat { Device.current.isPad ? 20 : 16 }
            static var detailsPadding : CGFloat { Device.current.isPad ? 50 : 30 }
            static var paddinSpecial: CGFloat { Device.current.isPad ? 30 : 20 }
            static var iconSizeCard: CGFloat { Device.current.isPad ? 36 : 24 }
            static var iconSizeDetails: CGFloat { Device.current.isPad ? 50 : 40 }
        }

        enum FontSize {
            
            static var small: CGFloat { Device.current.isPad ? 18 : 12 }
            static var medium: CGFloat { Device.current.isPad ? 27 : 18 }
            static var large: CGFloat { Device.current.isPad ? 30 : 20 }
            
        }

    }

