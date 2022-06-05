//
//  User.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation

class User{
    var id : String?
    var email : String?
    var password : String?
    var userName : String?
    var profileImageUrl : String?
    
    init(){}
    
    init(id:String,email:String,userName:String,profileImageUrl:String){
        self.id = id
        self.email = email
        self.userName = userName
        self.profileImageUrl = profileImageUrl
    }
    
    
}

extension User{
    static func FromJson(json:[String:Any])->User{
        let s = User()
        s.id = json["id"] as? String
        s.email = json["email"] as? String
        s.userName = json["userName"] as? String
        s.profileImageUrl = json["profileImageUrl"] as? String
        return s
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["id"] = self.id!
        json["email"] = self.email!
        json["userName"] = self.userName!
        json["profileImageUrl"] = self.profileImageUrl!
        return json
    }
}
