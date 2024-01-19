//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Rima Tague on 2024-01-18.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String
    @NSManaged public var image: String
    @NSManaged public var price: String
    @NSManaged public var information: String
    @NSManaged public var category: String

}

extension Dish : Identifiable {

}
