//
//  FavoriteViewModel.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation
import RealmSwift

class FavoritesViewModel: ViewModel {
    
    static let shared = FavoritesViewModel()
    private let realmManager = RealmManager.shared
    weak var delegate: FavoritesViewModelDelegate?
    
    var products: [ProductModel] = [] {
        didSet {
            delegate?.updateCollection()
        }
    }

    func getFavoriteProducts() {
        let products = getProducts().filter { $0.isFavorite == true }
        self.products = products
    }

    func toogleFavourite(at id: Int) {
        realmManager.toogleFavouriteProduct(at: id) {
            DispatchQueue.main.async {
                let products = self.getProducts().filter { $0.isFavorite == true }
                self.products = products
            }
        }
    }

    func getIDProduct(at indexPath: IndexPath) -> Int {
        getProducts()[indexPath.row].id
    }

    func getProducts() -> [ProductModel] {
        realmManager.getProducts()
    }

}
