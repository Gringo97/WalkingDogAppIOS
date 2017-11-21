//
//  UserProfile.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 27/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
  var Registro: Bool = false
    var sName:String?
    var sBreed: String?
    var iBirthDate: Date?
    var sType: String?
    
    var id:String?
    var sSoruceImg: String?

    
   
    init(dictionary:[String  : AnyObject]) {
        self.Registro = (dictionary["Conectado"] as? Bool)!
         self.sName = dictionary["Name"] as? String
         self.sBreed = dictionary["Breed"] as? String
         self.iBirthDate = dictionary["BirthDate"] as? Date
         self.sType = dictionary["Type"] as? String
        
         self.sSoruceImg = dictionary["Photo"] as? String
         self.id = dictionary["Id"] as? String
    }
    
    override init() {
        
    }
    

}


//class User: NSObject {
//    var id: String?
//    var name: String?
//    var email: String?
//    var profileImageUrl: String?
//    init(dictionary: [String: AnyObject]) {
//        self.id = dictionary["id"] as? String
//        self.name = dictionary["name"] as? String
//        self.email = dictionary["email"] as? String
//        self.profileImageUrl = dictionary["profileImageUrl"] as? String
//}

