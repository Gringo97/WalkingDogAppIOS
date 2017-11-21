//
//  ProfileCreate.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 27/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class ProfileCreate: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var txtfName:UITextField?
    @IBOutlet var txtfBreed:UITextField?
    @IBOutlet var fLegs:UISegmentedControl?
    @IBOutlet var fBirthDate:UIDatePicker?
    @IBOutlet var fPhoto:UIImageView?
    @IBOutlet var btnDog:UIButton?
    @IBOutlet var btnCat:UIButton?
    @IBOutlet var btnReptile:UIButton?
    @IBOutlet var btnHorse:UIButton?
    @IBOutlet var btnRodent:UIButton?
    let UserID = Auth.auth().currentUser?.uid

    let imagePicker = UIImagePickerController()
    var rutaImg:String!
    var imgData:Data?
    
    
    
    
    
    
    
    @IBAction func TypeSelected(sender: UIButton){
        
        if(sender == btnDog){
            DataHolder.sharedInstance.sType = "Dog"
            self.performSegue(withIdentifier: "TransAnimal", sender: nil)
        }else if(sender == btnCat ){
            DataHolder.sharedInstance.sType = "Cat"
            self.performSegue(withIdentifier: "TransAnimal", sender: nil)
        }else if(sender == btnReptile ){
            DataHolder.sharedInstance.sType = "Reptile"
            self.performSegue(withIdentifier: "TransRept", sender: nil)
        }else if(sender == btnHorse ){
            DataHolder.sharedInstance.sType = "Horse"
            self.performSegue(withIdentifier: "TransAnimal", sender: nil)
        }else if(sender == btnRodent ){
            DataHolder.sharedInstance.sType = "Rodent"
            self.performSegue(withIdentifier: "TransAnimal", sender: nil)
        }
        
    }
    
    @IBAction func actionGaleryBtn(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func actionCamaraBtn(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imgData = UIImageJPEGRepresentation(img!, 0.5)! as Data
        fPhoto?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func SendPersonalDataWhenRegister(){
        
    let name = txtfName!.text!
    let breed = txtfBreed!.text!
    let birthdate = fBirthDate!.date

    let databaseRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
        
        
        
        
        
        
        
    //SUBIDA FOTO PERFIL A STORAGE
     rutaImg = String(format:"ProfileImg/%d.jpg",UserID!)
     let imgRefPerfil = DataHolder.sharedInstance.firStorageRef?.child(rutaImg)
     let uploadTask = imgRefPerfil?.putData(imgData!,metadata:nil){
            (metadata,error) in
            guard let metadata = metadata else{
                return
            }
            let downloadURL = metadata.downloadURL
        }
   
    let type = DataHolder.sharedInstance.sType
        let post : [String : Any] = ["Id" : DataHolder.sharedInstance.Usuario?.uid , "Name" : name , "Breed" : breed , "BirthDate" : birthdate.description , "Type" : type,"Photo" : rutaImg, ]
    
       
    databaseRef.child("Profile").child((DataHolder.sharedInstance.Usuario?.uid)!).setValue(post)
    
        if(DataHolder.sharedInstance.sType == "Reptile"){
            self.performSegue(withIdentifier: "TransAfterProfile2", sender: nil)
        }else{
            self.performSegue(withIdentifier: "TransAfterProfile", sender: nil)
        }
    
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
