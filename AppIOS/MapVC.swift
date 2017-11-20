//
//  MapVC.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 6/6/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
   
    
     override func viewDidiLoad(){
        super.viewDidLoad()
    }
    
    
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        MapVC.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}
