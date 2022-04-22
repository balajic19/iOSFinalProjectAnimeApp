//
//  Users+CoreDataProperties.swift
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


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var emailAddress: String?
    @NSManaged public var password: String?
    @NSManaged public var faviouteAnime: String?

}

extension Users : Identifiable {

}
