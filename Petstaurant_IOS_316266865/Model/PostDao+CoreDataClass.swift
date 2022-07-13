//
//  PostDao+CoreDataClass.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//
//

import Foundation
import CoreData
import UIKit


@objc(PostDao)
public class PostDao: NSManagedObject {
    
    
    static var context:NSManagedObjectContext? = { () -> NSManagedObjectContext? in
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    
    
    static func createPost(post:Post){
        guard let context = context else {
            return
        }
        
        let p = PostDao(context: context)
        p.id = post.id
        p.uid = post.uid
        p.postTitle = post.postTitle
        p.postDescription = post.postDescription
        p.postImage = post.postImage
        
        do{
            try context.save()
        }catch let error as NSError{
            print("post create core error \(error) \(error.userInfo)")
        }
    }
    
    
    static func createPosts(posts:[Post]){
        guard let context = context else {
            return
        }
        for post in posts {
            let fetchRequest: NSFetchRequest<PostDao> = PostDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", post.id!)
            var postsDao: [NSManagedObject] = []
            do {
                postsDao = try context.fetch(fetchRequest)
               }
               catch {
                   print("error executing fetch request: \(error)")
               }
            if postsDao.count==0{
                let p = PostDao(context: context)
                p.id = post.id
                p.uid = post.uid
                p.postTitle = post.postTitle
                p.postDescription = post.postDescription
                p.postImage = post.postImage
            }
        }
        
        do{
            try context.save()
        }catch let error as NSError{
            print("posts create core error \(error) \(error.userInfo)")
        }
    }
    
    static func getPost(id:String, completion:@escaping (Post)->Void){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<PostDao> = PostDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let postsDao = try context.fetch(fetchRequest)
            var pArray:[Post] = []
            for pDao in postsDao{
                pArray.append(Post(uid: pDao.uid!, postDescription: pDao.postDescription!,
                                   postTitle: pDao.postTitle!, postImage: pDao.postImage!))
            }
            completion(pArray.first!)
        }catch let error as NSError{
            print("post fetch core error \(error) \(error.userInfo)")
            let post = Post()
            completion(post)
        }
    }
    
    static func getAllPosts()->[Post]{
        guard let context = context else {
            return []
        }

        do{
            let postsDao = try context.fetch(PostDao.fetchRequest())
            var pArray:[Post] = []
            for pDao in postsDao{
                pArray.append(Post(uid: pDao.uid!, postDescription: pDao.postDescription!,
                                   postTitle: pDao.postTitle!, postImage: pDao.postImage!))
            }
            return pArray
        }catch let error as NSError{
            print("post fetch core error \(error) \(error.userInfo)")
            return []
        }
    }
    
    
    static func updatePost(id:String, key:String, value:String){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<PostDao> = PostDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let postsDao = try context.fetch(fetchRequest)
            if(postsDao.count>0){
                let post = postsDao.first!
                post.setValue(value, forKey: key)
                try context.save()
            }
            
            return
        }catch let error as NSError{
            print("post update core error \(error) \(error.userInfo)")
            return
        }
    }
    
    
    static func deletePost(id:String){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<PostDao> = PostDao.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let postsDao = try context.fetch(fetchRequest)
            if(postsDao.count>0){
                let post = postsDao.first!
                context.delete(post)
                try context.save()
            }
            
            return
        }catch let error as NSError{
            print("post delete core error \(error) \(error.userInfo)")
            return
        }
    }
    
    
    static func deleteAllPosts(){
        guard let context = context else {
            return
        }
        do{
            let fetchRequest: NSFetchRequest<PostDao> = PostDao.fetchRequest()
            let postsDao = try context.fetch(fetchRequest)
            if(postsDao.count>0){
                for pDao in postsDao{
                    context.delete(pDao)
                }
                try context.save()
            }
            
            return
        }catch let error as NSError{
            print("posts delete core error \(error) \(error.userInfo)")
            return
        }
    }
    

}
