//
//  Model.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation
import UIKit

class ModelNotificatiponBase{
    let name:String
    init(_ name:String){
        self.name=name
    }
    func observe(callback:@escaping ()->Void){
        NotificationCenter.default.addObserver(forName: Notification.Name(name), object: nil, queue: nil){ data in
            NSLog("got notify")
            callback()
        }
    }
    
    func post(){
        NSLog("post notify")
        NotificationCenter.default.post(name: Notification.Name(name), object: self)
    }
    
}

class Model{
    let firebaseModel = ModelFirebase()
    static let instance = Model()
    static let postDataNotification = ModelNotificatiponBase("com.adar.postDataNotification")
    static let userDataNotification = ModelNotificatiponBase("com.adar.userDataNotification")
    private init(){
        
    }
    
    
    func createUser(email: String, password: String, userName: String, profileImageUrl: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        firebaseModel.createUser(email: email, password: password, userName: userName, profileImageUrl: profileImageUrl, onSuccess: {(user) in
            UserDao.createUser(user: user)
            onSuccess()
            Model.userDataNotification.post()
        }) { (errorMsg) in
            onError(errorMsg!)
            return
        }
    }
    
    func loginUser(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        
        firebaseModel.loginUser(email: email, password: password, onSuccess: {
            onSuccess()
        }) { (errorMsg) in
            onError(errorMsg!)
            return
        }
        
    }
    
    
    func logoutUser(completion: @escaping ()->Void){
        firebaseModel.logoutUser(){
            completion()
        }
    }
    
    
    func updateUserOnDB(uid:String, key:String, value:String, completion: @escaping ()->Void){
        UserDao.updateUser(uid: uid, key: key, value: value)
        firebaseModel.updateUserOnDB(uid: uid, key: key, value: value){
            completion()
            Model.userDataNotification.post()
        }
    }
    
    func getAllUsers(completion:@escaping ([User])->Void){
        UserDao.deleteAllUsers()
        firebaseModel.getAllUsers(){
            users in
            UserDao.createUsers(users: users)
        }
        
        return firebaseModel.getAllUsers(completion: completion)
    }
    
    func getUser(uid:String, completion:@escaping (User)->Void){
        return firebaseModel.getUser(uid:uid, completion: completion)
    }
    
    func getCoreUser(uid:String, completion:@escaping (User)->Void){
        return UserDao.getUser(uid: uid, completion: completion)
    }
    
    func savePostOnDB(post:Post, completion: @escaping ()->Void){
        PostDao.createPost(post: post)
        firebaseModel.savePostOnDB(post: post){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        PostDao.deleteAllPosts()
        firebaseModel.getAllPosts(){
            posts in
            PostDao.createPosts(posts: posts)
        }
        
        return firebaseModel.getAllPosts(completion: completion)
    }
    
    func getPost(byId:String)->Post?{
        return firebaseModel.getPost(byId: byId)
    }
    
    func getCorePost(id:String, completion:@escaping (Post)->Void){
        return PostDao.getPost(id: id, completion: completion)
    }
    
    func updatePostOnDB(id:String, key:String, value:String, completion: @escaping ()->Void){
        PostDao.updatePost(id: id, key: key, value: value)
        firebaseModel.updatePostOnDB(id: id, key: key, value: value){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func deletePost(id:String, completion: @escaping ()->Void){
        PostDao.deletePost(id: id)
        firebaseModel.deletePost(id: id){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func uploadImage(name:String, image:UIImage, callback:@escaping(_ url:String)->Void){
        firebaseModel.uploadImage(name: name, image: image, callback: callback)
    }
    
    func validateEmptyFields(fields:[String]) -> Bool{
        for field in fields{
            if field == "" {
                return false
            }
        }
        return true
    }
    
    func validatePassword(password:String) -> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}")
        return passwordRegex.evaluate(with: password)
    }
    
    func validateEmail(email:String) -> Bool{
        let emailRegex = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailRegex.evaluate(with: email)
    }
    
    func validatePasswordWithPasswordConfirm(password: String, passwordConfirm: String) -> Bool{
        return password == passwordConfirm
    }
    
    
    
    func tfBorderColor(textField: UITextField,completion: @escaping ()->Void){
        
        textField.layer.backgroundColor = UIColor.systemYellow.cgColor
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        textField.layer.borderWidth = 0.0
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 2.0
        textField.layer.shadowColor = UIColor.systemYellow.cgColor
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 1.0
        completion()
    }
    
    
    func btnBorderColor(button: UIButton,completion: @escaping ()->Void){
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemYellow.cgColor
        completion()
    }
    
    func txtViewBorderColor(textView: UITextView,completion: @escaping ()->Void){
        
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.systemYellow.cgColor
        completion()
    }
    
    
    func txtFieldBorderColor(textField: UITextField,completion: @escaping ()->Void){
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        completion()
    }
    
    
    
    
}
