//
//  ViewModel.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation

protocol ViewModel {
    var products: [ProductModel] { get }
    func getProducts() -> [ProductModel]
    func getIDProduct(at indexPath: IndexPath) -> Int
    func toogleFavourite(at id: Int)
}
