//
//  MiPin.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 15/6/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import MapKit

class MiPin: MKPointAnnotation {
    var idPin:String?
    var pinImage:UIImage?
    let ImagenHuella:UIImage? = nil
    var nombreImagen:String?
    var nameUser:String!
    var breedUser:String!
    var birthdateUser:String!
    
    
    func descargarImage(ruta:String){
        let islandRef = DataHolder.sharedInstance.firStorageRef?.child(ruta)
        //nombreImagen = islandRef!
        islandRef?.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("ERROR DESCARGA IMAGEN!!! ",error)
            } else {
                // Data for "images/island.jpg" is returned
                self.pinImage = UIImage(data: data!)
                
                DataHolder.sharedInstance.oscar = self.pinImage

                            }
        }
    }
    
    /*func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.pinImage = UIImage(data: data)
     
    
            }
        }
    }*/

}
