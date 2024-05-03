//
//  ProductModel.swift
//  new
//
//  Created by Баэль Рыспеков on 29/4/24.
//

import Foundation
import RealmSwift

class ProductRating: Object, Codable {

   @Persisted var rate : Double?
   @Persisted var count : Int?

}

class ProductModel: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String?
    @Persisted var price: Double?
    @Persisted var descriptionProduct: String?
    @Persisted var category: String?
    @Persisted var image: String?
    @Persisted var rating: ProductRating?
    @Persisted var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case descriptionProduct = "description"
        case category
        case image
        case rating
        case isFavorite
    }

    required override init() {
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        super.init()

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        price = try container.decodeIfPresent(Double.self, forKey: .price)
        descriptionProduct = try container.decodeIfPresent(String.self, forKey: .descriptionProduct)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        rating = try container.decodeIfPresent(ProductRating.self, forKey: .rating)

        if let isFavoriteValue = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) {
            isFavorite = isFavoriteValue
        }

    }
}

