//
//  UserDao+CoreDataProperties.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//
//

import Foundation
import CoreData


extension UserDao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDao> {
        return NSFetchRequest<UserDao>(entityName: "UserDao")
    }

    @NSManaged public var id: String?
    @NSManaged public var userName: String?
    @NSManaged public var email: String?
    @NSManaged public var profileImageUrl: String?

}

extension UserDao : Identifiable {

}
