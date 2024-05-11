//
//  ProductViewModelDelegate.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation

protocol ProductViewModelDelegate: AnyObject {
   func updateCollection()
   func handleError(_ error: String)
}
