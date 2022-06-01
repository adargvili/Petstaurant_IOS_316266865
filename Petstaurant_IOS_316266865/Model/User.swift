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
    
    init(email:String,password:String,userName:String,profileImageUrl:String){
        self.id = UUID().uuidString
        self.password = password
        self.email = email
        self.userName = userName
        self.profileImageUrl = profileImageUrl
    }
    
    
}

extension User{
    static func FromJson(json:[String:Any])->User{
        let s = User()
        s.id = json["id"] as? String
        s.password = json["password"] as? String
        s.email = json["email"] as? String
        s.userName = json["userName"] as? String
        s.profileImageUrl = json["image"] as? String
        return s
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["id"] = self.id!
        json["password"] = self.password!
        json["email"] = self.email!
        json["userName"] = self.userName!
        json["image"] = self.profileImageUrl!
        return json
    }
}
