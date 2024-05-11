//
//  ViewModel.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation
import RealmSwift

final class ProductViewModel: ViewModel {

    static let shared = ProductViewModel()
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    weak var delegate: ProductViewModelDelegate?

    var products: [ProductModelRealm] = [] {
        didSet {
            delegate?.updateCollection()
        }
    }

    func fetchProducts() {

        if getProducts().isEmpty {
            networkManager.fetchDataRealm(from: AppConfigs.NetworkURLs.producntsUrl) { result in
                switch result {
                case .success(let success):
                    self.saveProduct(products: success) {
                        self.fetchDataFromRealm()
                    }
                case .failure(let failure):
                    self.delegate?.handleError(failure.localizedDescription)
                }
            }
        } else {
            fetchDataFromRealm()
        }

    }

    func saveProduct(
        products: [ProductModelRealm],
        completion: @escaping () -> Void
    ) {
        realmManager.saveProduct(products: products) {
            completion()
        }
    }

    func fetchDataFromRealm() {
        self.products = getProducts()
    }

    func toogleFavourite(at id: Int) {
        realmManager.toogleFavouriteProduct(at: id) {
            DispatchQueue.main.async {
                self.delegate?.updateCollection()
            }
        }
    }

    func getIDProduct(at indexPath: IndexPath) -> Int {
        getProducts()[indexPath.row].id
    }

    func getProducts() -> [ProductModelRealm] {
        realmManager.getProducts()
    }
    
    func mySpecialMethod() {
        
        
        
    }

}
