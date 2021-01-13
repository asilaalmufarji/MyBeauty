//
//  OwnerSginUpViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 10/21/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase

class OwnerSginUpViewController: UIViewController {
    
    @IBOutlet weak var btnSginup: UIButton!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtSalonLocation: UITextField!
    @IBOutlet weak var txtEmailOwner: UITextField!
    @IBOutlet weak var txtSalonAccount: UITextField!
    @IBOutlet weak var txtSalonName: UITextField!
    @IBOutlet weak var txtOwnerName: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    //database refrence
    var ref:DatabaseReference!
    var refSalon:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
         btnSginup.layer.cornerRadius = 8
     ref = Database.database().reference().child("User")
    refSalon = Database.database().reference().child("Salon")
        // Do any additional setup after loading the view.
   
        self.txtPhoneNum.addBottomSignOwner()
        self.txtOwnerName.addBottomSignOwner()
         self.txtSalonName.addBottomSignOwner()
        self.txtSalonAccount.addBottomSignOwner()
         self.txtEmailOwner.addBottomSignOwner()
        self.txtSalonLocation.addBottomSignOwner()
        self.txtPass.addBottomSignOwner()
        self.txtConfirmPass.addBottomSignOwner()
        
        btnSginup.layer.cornerRadius = 10
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginO", sender: self)
    }
    
    @IBAction func btnSginup(_ sender: Any) {
        let mail = txtEmailOwner.text!
        let phoneNum = txtPhoneNum.text!
        let password = txtPass.text!
        if txtEmailOwner.text?.isEmpty == true  && txtOwnerName.text?.isEmpty == true && txtSalonName.text?.isEmpty == true && txtSalonAccount.text?.isEmpty == true && txtSalonLocation.text?.isEmpty == true &&
            txtPhoneNum.text?.isEmpty == true &&
            txtPass.text?.isEmpty == true && txtConfirmPass.text?.isEmpty == true {
           // print("fill all blank")
            let alert = UIAlertController(title: "Error", message: "please fill all blank", preferredStyle: .alert)
                                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                           self.present(alert, animated: true)
        }
        else if txtOwnerName.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "please write your name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            //print("please write your name ")
        }
        else if txtSalonName.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "please write your Salon name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
           // print("please write your Salon name ")
        }
        else if txtSalonAccount.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "please write your Salon account", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            //print("please write your Salon account ")
        }
        else if txtEmailOwner.text?.isEmpty == true || isValid(email: mail) == false {
            let alert = UIAlertController(title: "Error", message: "please write valid email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
                 //  print("please write valid email ")
               }
        else if txtPhoneNum.text?.isEmpty == true || isValidPhone(phone: phoneNum) == false {
            print ("write correct phone")
        }
        else if txtSalonLocation.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "please write your salon location", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true)
           // print("please write your location salon ")
        }
        else if txtPass.text?.isEmpty == true || isValidPassword(pass: password) == false {
            let alert = UIAlertController(title: "Error", message: "please write your Strong password , should have small letter, capital letter, special case and number (8 charcter) ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
           // print("please write your password")
        }
        else if txtConfirmPass.text?.isEmpty == true || txtConfirmPass.text != txtPass.text {
            let alert = UIAlertController(title: "Error", message: "please match your password", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true)
          //  print("please match password ")
        }
        else {
     //   if txtEmailOwner.text?.isEmpty == false  && txtOwnerName.text?.isEmpty == false && txtSalonName.text?.isEmpty == false && txtSalonAccount.text?.isEmpty == false && txtSalonLocation.text?.isEmpty == false && txtPass.text?.isEmpty == false && txtConfirmPass.text?.isEmpty == false {
            
     //   if isValid(email: mail) == true {
        Auth.auth().createUser(withEmail: txtEmailOwner.text!, password: txtPass.text!){(user,error)in
                            if error == nil{
                                self.sendDatatoFirebase()
                                self.send()
                                print("Successuflly registred")
                                
                                // alert
                                let alert = UIAlertController(title: "successfully", message: "register succesfully", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                    self.performSegue(withIdentifier: "loginO", sender: nil)
                                }))
                                self.present(alert, animated: true)
                                
                                
                                
                            }else{
                                let alert = UIAlertController(title: "Faild", message: "Faild to regiser in app", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                                    self.present(alert, animated: true)
                              //  print("Faild")
                            }
    }
    }
    }
    
    func sendDatatoFirebase() {
        let userId = Auth.auth().currentUser?.uid
           let user = [
               "userid" : userId!,
               "username" : txtOwnerName.text!,
               "SalonName" : txtSalonName.text!,
               "email" : txtEmailOwner.text!,
               "AccountSalon" : txtSalonAccount.text!,
               "PhoneNum" : txtPhoneNum.text!,
               "Role" : "Owner",
               "status" : "pending"
           ] as [String : Any]
           
           ref.child(userId!).setValue(user)
        }
    func send() {
        let userId = Auth.auth().currentUser?.uid
        let SalonRef = self.refSalon!.childByAutoId()
        let SalonId = SalonRef.key
        let salon = [
            "salonId" : SalonId! ,
            "userid" : userId! ,
            "SalonName" : txtSalonName.text!,
            "location" : txtSalonLocation.text!,
            "AccountSalon" : txtSalonAccount.text!,
            "email" : txtEmailOwner.text!,
            "PhoneNum" : txtPhoneNum.text!,
            "status" : "pending"
        ] as [String : Any]
        
        SalonRef.setValue(salon)
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
    
    func isValidPhone(phone : String) -> Bool {
        let phoneRegex = "^((\\9)|(7))[0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    func isValidPassword(pass : String) -> Bool {
         let regex = "(?=^.{8,}$)(?=.*\\d)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$"
         let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
         return passwordTest.evaluate(with: pass)
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
 extension UITextField{
      func addBottomSignOwner() {
       //    let bottomLine = CALayer()
        self.borderStyle = .none
         self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
          // bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        //bottomLine.backgroundColor = UIColor.white.cgColor
      //  borderStyle = .none
      //  bottomLine.borderColor = UIColor.black.cgColor
          // txtpass.borderStyle = UITextField.BorderStyle.none
       // self.layer.addSublayer(bottomLine)
       }
}
