//
//  Model.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation

class Model{
    
    static let instance = Model()
    var postList = [Post]()
    
    private init(){
        postList.append(Post(studentId: "111111111", postTitle: "adarTest1"))
        postList.append(Post(studentId: "222222222", postTitle: "adarTest2"))
        postList.append(Post(studentId: "333333333", postTitle: "adarTest3"))
        postList.append(Post(studentId: "444444444", postTitle: "adarTest4"))
    }
    
    func addPostToList(post:Post){
        postList.append(post)
    }
}
