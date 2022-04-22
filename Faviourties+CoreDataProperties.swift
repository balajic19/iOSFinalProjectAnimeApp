//
//  Faviourties+CoreDataProperties.swift
//  Anime
//
//  Created by
// Balaji Chandupatla
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
//
//

import Foundation
import CoreData


extension Faviourties {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Faviourties> {
        return NSFetchRequest<Faviourties>(entityName: "Faviourties")
    }

    @NSManaged public var userId: String?
    @NSManaged public var faviourtieId: String?

}

extension Faviourties : Identifiable {

}
