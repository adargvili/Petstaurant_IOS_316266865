//
//  Post.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation

class Post{
    public var id: String? = ""
    public var uid: String? = ""
    public var postTitle: String? = ""
    public var postDescription: String? = ""
    public var postImage: String? = ""
    
    init(){}
    
    init(uid:String, postDescription:String, postTitle:String, postImage:String){
        self.id = UUID().uuidString
        self.uid = uid
        self.postDescription = postDescription
        self.postTitle = postTitle
        self.postImage = postImage
    }
    
    
}

extension Post{
    static func FromJson(json:[String:Any])->Post{
        let s = Post()
        s.id = json["id"] as? String
        s.uid = json["uid"] as? String
        s.postTitle = json["title"] as? String
        s.postDescription = json["description"] as? String
        s.postImage = json["image"] as? String
        return s
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["id"] = self.id!
        json["uid"] = self.uid
        json["title"] = self.postTitle!
        json["description"] = self.postDescription!
        json["image"] = self.postImage!
        return json
    }
}
