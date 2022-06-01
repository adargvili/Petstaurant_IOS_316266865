//
//  ModelFireBase.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class ModelFirebase{
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    init(){
        
    }
    
    func createUser(user:User, completion:@escaping ()->Void){
        db.collection("Users").document(user.id!).setData(
            user.toJson())
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with")
            }
            completion()
        }
    }
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        db.collection("Posts").getDocuments() { (querySnapshot, err) in
            var posts = [Post]()
            if let err = err {
                print("Error getting documents: \(err)")
                completion(posts)
            } else {
                for document in querySnapshot!.documents {
                    let post = Post.FromJson(json: document.data())
                    posts.append(post)
                    completion(posts)
                }
            }
        }
    }
    
    func addPostToList(post:Post, completion:@escaping ()->Void){
        db.collection("Posts").document(post.id!).setData(
            post.toJson())
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with")
            }
            completion()
        }
    }
    
    func getPost(byId:String)->Post?{
        return nil
    }
    
    func delete(post:Post){
        
    }
    
    
    func uploadImage(name:String, image:UIImage, callback: @escaping (_ url:String)->Void){
        let storageRef = storage.reference()
        let imageRef = storageRef.child(name)
        let data = image.jpegData(compressionQuality: 0.8)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metaData){(metaData,error) in
            imageRef.downloadURL { (url, error) in
                let urlString = url?.absoluteString
                callback(urlString!)
            }
        }
    }
    
}
