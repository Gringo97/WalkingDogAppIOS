//
//  mapView.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 6/6/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import FirebaseDatabase
import GeoFire


class mapView: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var lblPopUpName: UILabel!
    @IBOutlet weak var lblPopUpBreed: UILabel!
    @IBOutlet weak var lblPopUpBirthdate: UILabel!
    @IBOutlet weak var userPhoto: UIView!
    @IBOutlet weak var Exit: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var Chat: UIButton!
    @IBOutlet weak var dislike: UIButton!
    
    let UserID = Auth.auth().currentUser?.uid
    var ImagenDescarga:UIImage?
    let locationManager = CLLocationManager()
     var getMovedMapCenter: CLLocation!
      var miPinSelect:MiPin?
    var misPines:[String:MiPin]=[:]
    var messagesController: MessagesController?
    var annotationUser:MiPin?
    var boolCreatedPin:Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        //mapView.delegate = self
        mapView.showsUserLocation=true 
        popUp.isHidden = true
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
                        getMovedMapCenter =  CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        DataHolder.sharedInstance.geoFire?.setLocation(getMovedMapCenter, forKey:UserID)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
        searchUsers()
        
        
        if(!boolCreatedPin){
            boolCreatedPin=true
            annotationUser = MiPin()
            annotationUser?.coordinate = userLocation.coordinate
            annotationUser?.title = "HEY"
            annotationUser?.idPin="PRUEBA"
            //annotation.descargarImage(ruta: RutaImg)
            self.mapView.addAnnotation(annotationUser!)
        }
        else{
            annotationUser?.coordinate=userLocation.coordinate
        }
    }
    
    
    
    
   
    
    /*
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationReuseId = "Place"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView?.annotation = annotation
        }
        anView?.image = ImagenDescarga
        anView?.backgroundColor = UIColor.clear
        anView?.canShowCallout = false
        return anView
    }*/
    
    func searchUsers(){
        
        let myQuery = DataHolder.sharedInstance.geoFire?.query(at: getMovedMapCenter, withRadius: 1000)
        
        myQuery?.observe(.keyEntered, with: { (key, location) in
            let aux = String(format: "geolocs/%@/l", key!)
           Database.database().reference().child(aux).observeSingleEvent(of: .value, with: { (snapshot) in
            if(self.UserID != key){
             var Estado = false
               
                if(self.UserID != key){
                    DataHolder.sharedInstance.firDatabaseRef.child("Profile").child(key!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        let value = snapshot.value as? [String : AnyObject] ?? [:]
                   
                      var Estado2 = value["Conectado"]
                        if (Estado2 != nil){
                        Estado = Estado2 as! Bool
                        
                        }
                    })
  /* https://digitalleaves.com/blog/2016/12/building-the-perfect-ios-map-ii-completely-custom-annotation-views/ 
                     https://iostutorialbyani.blogspot.com.es/2016/08/custom-map-annotation-pin-in-swift.html */
                   
                    if(Estado == true){
                    let annotationTemp=self.misPines[key!]
                    
                    if(annotationTemp==nil){
                        let annotation = MiPin()
                        annotation.coordinate = (location?.coordinate)!
                        DataHolder.sharedInstance.firDatabaseRef.child("Profile").child(key!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                            let value = snapshot.value as? [String : AnyObject] ?? [:]
                            print("----->",snapshot)
                           // var Nombre:String = value["Name"] as! String
                            print(value["Photo"] as! String)
                            //var RutaImg:String = value["Photo"] as! String
                            //self.descargarImage(ruta:RutaImg)
                            annotation.title = value["Name"] as? String
                            annotation.idPin=key
                            annotation.nameUser = value["Name"] as? String
                            annotation.breedUser = value["Breed"] as? String
                            annotation.birthdateUser  = value["BirthDate"] as? String
                            self.misPines[key!]=annotation
                          // annotation.descargarImage(ruta: RutaImg)
                            self.mapView.addAnnotation(annotation)
                          //annotation.pinImage = self.ImagenDescarga
                            
                           //self.mapView(self.mapView, viewFor: annotation)
                        })
                    }
                    }
                    else{
                      //  annotationTemp.coordinate=(location?.coordinate)!
                    }
                    
                    
                    
                    
                }
                
                
              
                
            
            }
            
     
            
           })
            
        })
        
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationIdentifier = "Identifier"
//        var annotationView: MKAnnotationView?
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotationView = av
//        }
//        
//        if let annotationView = annotationView {
//            // Configure your annotation view here
//            annotationView.canShowCallout = true
//        
//        
//        
//        
//            annotationView.image = UIImage(named:"animal-paw-print")!
//           // annotationView.image = annotation.pinImage
//        }
//        
//        return annotationView
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
             return annotationView
        }
        else {
            let annotationView = MKPinAnnotationView(annotation:annotation,reuseIdentifier:annotationIdentifier)
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "huella")
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
            
            //annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            //annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        //return nil
    }
    @IBAction func hablar(){
        Database.database().reference().child("Profile").child((miPinSelect?.idPin)!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            if let value = snapshot.value as? [String:AnyObject] {
                let user = UserProfile(dictionary:value)
                user.id = snapshot.key
                self.messagesController?.showChatControllerForUser(user)
            }
     
    })
    }
    
    
    @IBAction func btnVolver() {
                let databaseRef = Database.database().reference()
        DataHolder.sharedInstance.sEmail=""
        DataHolder.sharedInstance.sPass=""
        let post : [String : Any] = ["Conectado" : false]
        databaseRef.child("Profile").child((DataHolder.sharedInstance.Usuario?.uid)!).updateChildValues(post)
        try! Auth.auth().signOut()
        
        
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        popUp.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
      miPinSelect = view.annotation as! MiPin
        lblPopUpName.text = miPinSelect?.nameUser
        lblPopUpBreed.text = miPinSelect?.breedUser
        lblPopUpBirthdate.text = miPinSelect?.birthdateUser
        
        popUp.isHidden = false
        print("HEY!!!!!!!!! ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set initial location in Honolulu
    
 


}
