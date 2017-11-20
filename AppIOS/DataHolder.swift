//
//  DataHolder.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 25/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import GeoFire


class DataHolder: NSObject {
    static let sharedInstance:DataHolder=DataHolder()
    
    var firDatabaseRef: DatabaseReference!
    var firStorage:Storage?
    var firStorageRef:StorageReference?
    
    var sType:String = ""
    var Usuario: User?
    var geoFireRef:DatabaseReference!
    var geoFire:GeoFire?
    
    var oscar:UIImage?
    
    
    
    var arProfile: Array<UserProfile>?
    
    
    var sEmail:String?
    var sPass:String?
    
    
    
    
    
    func initFirebase(){
        FirebaseApp.configure()
        firDatabaseRef = Database.database().reference()
        firStorage = Storage.storage()
        firStorageRef = firStorage?.reference()
        geoFireRef=Database.database().reference().child("geolocs")
        geoFire=GeoFire(firebaseRef : geoFireRef)
    }
    
    
    func saveData(){
        let props = UserDefaults.standard
        props.setValue(sEmail, forKey: "email_login")
        props.setValue(sPass, forKey: "pass_login")
        props.synchronize()
    }
    func loadData(){
        let props = UserDefaults.standard
        sEmail=props.string(forKey: "email_login")
        sPass=props.string(forKey: "pass_login")
        if(sEmail==nil){
            sEmail=""
        }
        if(sPass==nil){
            sPass=""
        }
        
        
    }

}
