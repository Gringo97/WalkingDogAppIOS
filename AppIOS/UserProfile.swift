//
//  UserProfile.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 27/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
    
    var sName:String?
    var sBreed: String?
    var iBirthDate: Date?
    var sType: String?
    var Registro: BooleanLiteralType = false
    
    var sSoruceImg: String?
    
   
    init(values:[String:AnyObject]) {
        sName = values["Name"] as? String
        sBreed = values["Breed"] as? String
        iBirthDate = values["Birthdate"] as? Date
        sType = values["Type"] as? String

    }

}
