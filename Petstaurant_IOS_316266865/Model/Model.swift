//
//  Model.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation

class Model{
    let firebaseModel = ModelFirebase()
    static let instance = Model()
    var postList = [Post]()
    
    private init(){
       
    }
    
    func addPostToList(post:Post, completion: @escaping ()->Void){
        firebaseModel.addPostToList(post: post){
            completion()
        }
    }
    
    func getAllPosts(completion:@escaping ([Post])->Void){
        return firebaseModel.getAllPosts(completion: completion)
    }
    
    func getPost(byId:String)->Post?{
        return firebaseModel.getPost(byId: byId)
    }
    
    func delete(post:Post){
        firebaseModel.delete(post: post)
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
    
    
}
