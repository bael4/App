//
//  Rating+CoreDataProperties.swift
//  new
//
//  Created by Баэль Рыспеков on 11/5/24.
//
//

import Foundation
import CoreData


extension Rating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        return NSFetchRequest<Rating>(entityName: "Rating")
    }

    @NSManaged public var count: Int16
    @NSManaged public var rate: Double

}

extension Rating : Identifiable {

}
