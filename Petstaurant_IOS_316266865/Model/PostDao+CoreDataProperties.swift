//
//  PostDao+CoreDataProperties.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//
//

import Foundation
import CoreData


extension PostDao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostDao> {
        return NSFetchRequest<PostDao>(entityName: "PostDao")
    }

    @NSManaged public var postDescription: String?
    @NSManaged public var postTitle: String?
    @NSManaged public var uid: String?
    @NSManaged public var id: String?
    @NSManaged public var postImage: String?

}

extension PostDao : Identifiable {

}
