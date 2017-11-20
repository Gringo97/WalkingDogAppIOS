//
//  Login.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 25/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class Login: UIViewController {
    
    @IBOutlet var txtEmail:UITextField?
    @IBOutlet var txtPassword:UITextField?
    @IBOutlet var loginfail:UILabel?
        @IBOutlet var uiswitchRecordar:UISwitch?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(Login.dismissKeyboard))
        view.addGestureRecognizer(tap)
        txtEmail?.text=DataHolder.sharedInstance.sEmail
        txtPassword?.text=DataHolder.sharedInstance.sPass
        self.uiswitchRecordar?.isOn=true
        if(txtEmail != nil){
            login()
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        
        view.endEditing(true)
    }
    @IBAction func login() {
        
        
        let databaseRef = Database.database().reference()
          let post : [String : Any] = ["Conectado" : true]
        

        if((txtEmail?.text != "" ) && (txtPassword?.text != "")){
            Auth.auth().signIn( withEmail: (txtEmail?.text)! , password: (txtPassword?.text)!){ (user, error) in
            
                if(error==nil){
                    
                    
                    
                    if(self.uiswitchRecordar?.isOn)!{
                        DataHolder.sharedInstance.sEmail = self.txtEmail?.text
                        print(DataHolder.sharedInstance.sEmail,"GUARDADOOOOOO0")
                        DataHolder.sharedInstance.sPass = self.txtPassword?.text
                        DataHolder.sharedInstance.saveData()
                    }else{
                        DataHolder.sharedInstance.sEmail = "abcd@gmail.com"
                        DataHolder.sharedInstance.sPass = "123456"
                        DataHolder.sharedInstance.saveData()
                    }

                    
                    let UserID = Auth.auth().currentUser?.uid

                   DataHolder.sharedInstance.firDatabaseRef.child("Profile").child(UserID!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in

                    DataHolder.sharedInstance.Usuario=user

                    let value = snapshot.value as? NSDictionary
                        if(value == nil){
                             databaseRef.child("Profile").child((DataHolder.sharedInstance.Usuario?.uid)!).updateChildValues(post)
                            self.performSegue(withIdentifier: "Login2", sender: self)

                            print(snapshot.key)
                        }else{
                            print((Auth.auth().currentUser?.uid)! + "login2")
                          
                            
                            databaseRef.child("Profile").child((DataHolder.sharedInstance.Usuario?.uid)!).updateChildValues(post)
                            self.performSegue(withIdentifier: "Login1", sender: self)
                            
                        }
                    
                    
                    
                    
                   })
                    
                    
                    
                    
                    
                    
                    
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: "The password don't match with the email", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }else{
            let alertController = UIAlertController(title: "Error", message: "Introduce a valid Email and Password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
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
