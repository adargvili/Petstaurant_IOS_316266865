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
    var postList = [Post]()
    
    private init(){
       
    }
    
    
    func createUser(email: String, password: String, userName: String, profileImageUrl: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        firebaseModel.createUser(email: email, password: password, userName: userName, profileImageUrl: profileImageUrl, onSuccess: {
            onSuccess()
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
    
    func saveUserOnDB(user:User, completion: @escaping ()->Void){
        firebaseModel.saveUserOnDB(user: user){
            completion()
        }
    }
    
    
    func updateUserOnDB(uid:String, key:String, value:String, completion: @escaping ()->Void){
        firebaseModel.updateUserOnDB(uid: uid, key: key, value: value){
            completion()
        }
    }
    
    func getUser(uid:String, completion:@escaping (User)->Void){
        return firebaseModel.getUser(uid:uid, completion: completion)
    }
    
    func savePostOnDB(post:Post, completion: @escaping ()->Void){
        firebaseModel.savePostOnDB(post: post){
            completion()
            Model.postDataNotification.post()
        }
    }
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        return firebaseModel.getAllPosts(completion: completion)
    }
    
    func getPost(byId:String)->Post?{
        return firebaseModel.getPost(byId: byId)
    }
    
    func updatePostOnDB(id:String, key:String, value:String, completion: @escaping ()->Void){
        firebaseModel.updatePostOnDB(id: id, key: key, value: value){
            completion()
        }
    }
    
    func deletePost(id:String, completion: @escaping ()->Void){
        firebaseModel.deletePost(id: id){
            completion()
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
    
    
}
