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
    
    
    
    static func createUser(user:User){
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
            print("user create core error \(error) \(error.userInfo)")
        }
    }
    
    
    static func createUsers(users:[User]){
        guard let context = context else {
            return
        }
        for user in users {
            let fetchRequest: NSFetchRequest<UserDao> = UserDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", user.id!)
            var usersDao: [NSManagedObject] = []
            do {
                usersDao = try context.fetch(fetchRequest)
               }
               catch {
                   print("error executing fetch request: \(error)")
               }
            if usersDao.count==0{
                let us = UserDao(context: context)
                us.id = user.id
                us.userName = user.userName
                us.email = user.email
                us.profileImageUrl = user.profileImageUrl
            }
        }
        
        do{
            try context.save()
        }catch let error as NSError{
            print("users create core error \(error) \(error.userInfo)")
        }
    }
    
    static func getUser(uid:String, completion:@escaping (User)->Void){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<UserDao> = UserDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", uid)
            let usersDao = try context.fetch(fetchRequest)
            var usArray:[User] = []
            for usDao in usersDao{
                usArray.append(User(id:usDao.id!, email: usDao.email! ,userName: usDao.userName! ,profileImageUrl: usDao.profileImageUrl! ))
            }
            if usArray.count>0{
            completion(usArray.first!)
            }
            else{
                let user = User()
                completion(user)
            }
        }catch let error as NSError{
            print("user fetch core error \(error) \(error.userInfo)")
            let user = User()
            completion(user)
        }
    }
    
    static func getAllUsers()->[User]{
        guard let context = context else {
            return []
        }

        do{
            let usersDao = try context.fetch(UserDao.fetchRequest())
            var usArray:[User] = []
            for usDao in usersDao{
                usArray.append(User(id:usDao.id!, email: usDao.email! ,userName: usDao.userName! ,profileImageUrl: usDao.profileImageUrl! ))
            }
            return usArray
        }catch let error as NSError{
            print("user fetch core error \(error) \(error.userInfo)")
            return []
        }
    }
    
    
    static func updateUser(uid:String, key:String, value:String){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<UserDao> = UserDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", uid)
            let usersDao = try context.fetch(fetchRequest)
            if(usersDao.count>0){
                let user = usersDao.first!
                user.setValue(value, forKey: key)
                try context.save()
            }
            
            return
        }catch let error as NSError{
            print("user update core error \(error) \(error.userInfo)")
            return
        }
    }
    
    
    static func deleteAllUsers(){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<UserDao> = UserDao.fetchRequest()
            let usersDao = try context.fetch(fetchRequest)
            if(usersDao.count>0){
                for uDao in usersDao{
                    context.delete(uDao)
                }
                try context.save()
            }
            
            return
        }catch let error as NSError{
            print("users delete core error \(error) \(error.userInfo)")
            return
        }
    }
}
