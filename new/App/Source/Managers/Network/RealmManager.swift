//
//  RealmManager.swift
//  new
//
//  Created by Баэль Рыспеков on 2/5/24.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()

    let realm = try! Realm()

    func getProducts() -> [ProductModel] {
         Array(realm.objects(ProductModel.self))

    }

    func saveProduct(
        products: [ProductModel],
        completion: @escaping () -> Void
    ) {
        DispatchQueue.main.async {
            do {
                
                if self.getProducts() != products {
                    try self.realm.write {
                        self.realm.add(products, update: .modified)
                    }
                }
                completion()
            } catch {
                print("Ошибка при доступе к Realm: \(error)")
            }
        }
    }

    func toogleFavouriteProduct(
        at id: Int,
        completion: @escaping () -> Void
    ) {
        
        DispatchQueue.main.async {
            
            if let product = self.realm.object(ofType: ProductModel.self, forPrimaryKey: id) {
                do {
                    try self.realm.write {
                        product.isFavorite.toggle()
                        self.realm.add(product, update: .modified)
                    }
                    completion()
                } catch {
                    print("Ошибка при обновлении объекта в Realm: \(error)")
                }
            } else {
                print("Продукт с id \(id) не найден в Realm")
            }
            
        }
    }

}
