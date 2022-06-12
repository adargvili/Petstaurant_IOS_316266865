//
//  UserDao+CoreDataClass.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(UserDao)
public class UserDao: NSManagedObject {
    
    static var context:NSManagedObjectContext? = { () -> NSManagedObjectContext? in
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    
    
    static func add(user:User){
        guard let context = context else {
            return
        }
        
        let us = UserDao(context: context)
        us.id = user.id
        us.userName = user.userName
        us.email = user.email
        us.profileImageUrl = user.profileImageUrl
        
        do{
            try context.save()
        }catch let error as NSError{
            print("user add core error \(error) \(error.userInfo)")
        }
    }

}
