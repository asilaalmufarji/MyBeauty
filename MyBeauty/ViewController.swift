//
//  ViewController.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var btnLoginAdmin: UIButton!
    @IBOutlet weak var txtPasswordAdmin: UITextField!
    @IBOutlet weak var txtEmailAdmin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnLoginAdmin(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmailAdmin.text! , password: txtPasswordAdmin.text!){(user,error) in
            if error == nil {
                self.performSegue(withIdentifier: "success", sender: nil)
                print("sucess")
            }
            else{
               print("error")
            }
        }
    
   
}
}
