//
//  SingUp.swift
//  AppIOS
//
//  Created by Óscar de la Fuente Ruiz on 25/4/17.
//  Copyright © 2017 Óscar de la Fuente Ruiz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SingUp: UIViewController {
    @IBOutlet var txtfEmail:UITextField?
    @IBOutlet var txtfPass:UITextField?
    @IBOutlet var txtfRepass:UITextField?

  
   
    
    @IBAction func accionkr() {
        Auth.auth().createUser(withEmail: (txtfEmail?.text)!, password:(txtfPass?.text)!){ (user, error) in
            if error != nil {
                if (self.txtfEmail?.text == "" || self.txtfPass?.text == "" || self.txtfRepass?.text == ""){
                    let alertController = UIAlertController(title: "Error", message: "Please complete all the fields", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    let alertController = UIAlertController(title: "Error", message: (error?.localizedDescription)!, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
            }else if(error == nil) {
                //COMO SABER SI HA SELECCIONADO PERRO GATO O REPTIL
               // if(self.fType?.value(String,"Dogs") || self.fType?.value(String,"Cats")){
                    self.performSegue(withIdentifier: "TransFin2", sender: self)
 
               // }else if(self.fType?.value(String,"Reptile")){
               //     self.performSegue(withIdentifier: transFin, sender: self)

               // }
                
            }
            
        }

    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
