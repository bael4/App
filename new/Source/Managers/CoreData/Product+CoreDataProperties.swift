//
//  Product+CoreDataProperties.swift
//  new
//
//  Created by Баэль Рыспеков on 11/5/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var category: String?
    @NSManaged public var descriptionn: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var rating: Rating?

}

extension Product : Identifiable {

}
