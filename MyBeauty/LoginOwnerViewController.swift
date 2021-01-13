//
//  LoginOwnerViewController.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class LoginOwnerViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var ref : DatabaseReference!
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
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
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!){(user,error)in
                     
                     if error == nil {
                         
                         self.getData()
                         print("success")
                      //   self.performSegue(withIdentifier: "start", sender: self)
                        
                     }else{
                         print("faild")
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
  
    
    @IBAction func btnSginup(_ sender: Any) {
        performSegue(withIdentifier: "sginup", sender: self)
    }
    
    func getData() {
    let ownerid = Auth.auth().currentUser?.uid
    ref.child("Owner").queryOrdered(byChild: "ownerid").queryEqual(toValue: ownerid).observe(.value){(snapshot) in
        if let data = snapshot.value as? NSDictionary{
            let userinfo = data.value(forKey: ownerid!) as! NSDictionary
            print(userinfo)
            let role = userinfo.value(forKey: "Role") as! String
            let username = userinfo.value(forKey: "username") as! String
            let salonname = userinfo.value(forKey: "SalonName") as! String
            let email = userinfo.value(forKey: "email") as! String
            let account = userinfo.value(forKey:"AccountSalon") as! String
            UserDefaults.standard.set(username, forKey: "username")
            UserDefaults.standard.set(salonname, forKey: "SalonName")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(account, forKey: "AccountSalon")
            if role == "Accept"{
                print("succes ")
                self.performSegue(withIdentifier: "start", sender: self)
            }
            else if role == "waiting" {
              //  print("success owner")
               print("please waiting after accepte")
            }
        }
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
}
