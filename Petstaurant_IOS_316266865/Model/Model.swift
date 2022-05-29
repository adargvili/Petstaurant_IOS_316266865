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
        postList.append(Post(postId: "",postDescription: "111111111", postTitle: "adarTest1",postImage: ""))
    }
    
    func addPostToList(post:Post, completion: @escaping ()->Void){
        firebaseModel.addPostToList(post: post){
            completion()
        }
    }
}
