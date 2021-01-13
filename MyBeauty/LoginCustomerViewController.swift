//
//  LoginCustomerViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 10/24/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class LoginCustomerViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSginup(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: self)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let mail = txtEmail.text!
        
        if txtEmail.text?.isEmpty == true  && txtPassword.text?.isEmpty == true {
            print("fill all blank")
        }
        else if txtEmail.text?.isEmpty == true || isValid(email: mail) == false {
                   print("please write valid email ")
               }
        else if txtPassword.text?.isEmpty == true {
            print("please write correct password ")
        }
        else {
        Auth.auth().signIn(withEmail: txtEmail.text! , password: txtPassword.text!){(user,error) in
                   if error == nil {
                       print("succes")
                   }
                   else{
                      print("error")
                   }
    }
    }
    }
    func isValid(email : String) -> Bool {
         let emailReg = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
         "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
         "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
         "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
         "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
         "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
         "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
         let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailReg)
         return emailTest.evaluate(with: email)
     }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

