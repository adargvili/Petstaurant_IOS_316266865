//
//  ModelFireBase.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit

class ModelFirebase{
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    init(){
        
    }
    
    func createUser(email:String, password:String,userName:String,profileImageUrl:String,  onSuccess: @escaping (User) -> Void, onError:  @escaping (_ errorMessage: String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                onError(error.localizedDescription)
            }
            else{
                let user = User(id: result!.user.uid, email: email, userName: userName, profileImageUrl: profileImageUrl)
                UserDefaults.standard.set(user.id, forKey: "uid")
                UserDefaults.standard.set(user.email, forKey: "email")
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                self.saveUserOnDB(user: user){}
                onSuccess(user)
            }
        }
    }
    
    func saveUserOnDB(user:User, completion:@escaping ()->Void){
        db.collection("users").document(user.id!).setData(
            user.toJson())
        { err in
            if let err = err {
                print("Error saving document: \(err)")
            } else {
                print("Document saved")
            }
            completion()
        }
    }
    
    
    
    func loginUser(email:String, password:String,  onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                onError(error.localizedDescription)
            }
            else{
                FirebaseAuth.Auth.auth().addStateDidChangeListener{ auth, user in
                    if let user = user {
                        
                        UserDefaults.standard.set(user.uid, forKey: "uid")
                        UserDefaults.standard.set(user.email, forKey: "email")
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                    }
                }
                onSuccess()
            }
        }
        
    }
    
    func logoutUser(completion:@escaping ()->Void){
        
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set("", forKey: "uid")
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            completion()
        } catch let err {
            print(err)
        }
    }
    
    
    func updateUserOnDB(uid: String, key: String, value: String, completion:@escaping ()->Void){
        db.collection("users").document(uid).updateData([key : value])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document updated")
            }
            completion()
        }
    }
    
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        db.collection("posts").getDocuments() { (querySnapshot, err) in
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
    
    func getUser(uid:String, completion:@escaping (User)->Void){
        db.collection("users").whereField("id", isEqualTo: uid).getDocuments() { (querySnapshot, err) in
            var user = User()
            if let err = err {
                print("Error getting documents: \(err)")
                completion(user)
            } else {
                for document in querySnapshot!.documents {
                    let user = User.FromJson(json: document.data())
                    completion(user)}
            }
        }
    }
    
    
    
    func savePostOnDB(post:Post, completion:@escaping ()->Void){
        db.collection("posts").document(post.id!).setData(
            post.toJson())
        { err in
            if let err = err {
                print("Error saving document: \(err)")
            } else {
                print("Document saved")
            }
            completion()
        }
    }
    
    func updatePostOnDB(id: String, key: String, value: String, completion:@escaping ()->Void){
        db.collection("posts").document(id).updateData([key : value])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document updated")
            }
            completion()
        }
    }
    
    
    func getPost(byId:String)->Post?{
        return nil
    }
    
    func deletePost(id:String, completion:@escaping ()->Void){
        db.collection("posts").whereField("id", isEqualTo: id).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion()
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
        
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
