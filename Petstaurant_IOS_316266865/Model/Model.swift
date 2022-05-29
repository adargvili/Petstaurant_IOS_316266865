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
    
    
}
