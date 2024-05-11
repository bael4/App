//
//  VCViewModel.swift
//  new
//
//  Created by Баэль Рыспеков on 11/5/24.
//

import Foundation

protocol VCViewModelDelegate: AnyObject {
    func didUpdate()
}

class VCViewModel {
    
    static let shared = VCViewModel()
    
    let coredataManager = CoreDataManager.shared
    let networkManager = NetworkManager.shared
    
    weak var delegate: VCViewModelDelegate?

    var items: [Product] = [] {
        didSet {
            delegate?.didUpdate()
        }
    }

    func fetchData() {
        if UserDefaults.standard.bool(forKey: "hasData") {
            self.items =  self.coredataManager.fetchAllCharactersBaseMain()
        } else {
            networkManager.fetchData(from: AppConfigs.NetworkURLs.producntsUrl) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.coredataManager.saveProductsToCoreData(products: success) {
                        if let items = self?.coredataManager.fetchAllCharactersBaseMain() {
                            self?.items = items
                        }
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }

}
