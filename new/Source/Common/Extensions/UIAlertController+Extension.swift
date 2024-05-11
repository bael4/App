//
//  UIAlertController+Extension.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import UIKit

extension UIAlertController {
    
    convenience init(title: String?, message: String?, font: UIFont) {
        self.init(title: title, message: message, preferredStyle: .alert)
        let attributedMessage = NSMutableAttributedString(
            string: message ?? "",
            attributes: [NSAttributedString.Key.font: font]
        )
        self.setValue(attributedMessage, forKey: "attributedMessage")
    }
    
    static func showAlert(
        title: String,
        message: String,
        actionTitle: String,
        presentingViewController: UIViewController
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            font: UIFont.systemFont(ofSize: AppConfigs.FontSize.large, weight: .bold)
        )
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        presentingViewController.present(alert, animated: true, completion: nil)
    }

}

