//
//  Extensions.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 21/11/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//



import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
       self.image = nil
        
    
        let iPerfAux = DataHolder.sharedInstance.firStorageRef?.child(DataHolder.sharedInstance.usuarioLinkFoto!)
        if(iPerfAux != nil){
            print(iPerfAux)
            iPerfAux?.getData(maxSize: 1*1024*1024) { data , error in
                if error  != nil{
                    
                }
                let imagen = UIImage(data: data!)
                self.image =  imagen
        }
        
            
            
            
        }
    }
    
}

