//
//  CustomerSginUpViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 10/22/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class CustomerSginUpViewController: UIViewController {

    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var txtConfPass: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhonenum: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    //database refrence
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
 ref = Database.database().reference().child("User")
         btnC.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
        self.txtPass.addBottomSignCustomer()
        self.txtEmail.addBottomSignCustomer()
        self.txtConfPass.addBottomSignCustomer()
        self.txtLocation.addBottomSignCustomer()
        self.txtPhonenum.addBottomSignCustomer()
        self.txtUsername.addBottomSignCustomer()
        
        btnC.layer.cornerRadius = 15
    }
    
    @IBAction func btnSginup(_ sender: Any) {
        let mail = txtEmail.text!
               if txtUsername.text?.isEmpty == true  && txtEmail.text?.isEmpty == true && txtPhonenum.text?.isEmpty == true && txtLocation.text?.isEmpty == true && txtPass.text?.isEmpty == true && txtConfPass.text?.isEmpty == true {
                   print("fill all blank")
               }
               else if txtUsername.text?.isEmpty == true {
                   print("please write your name ")
               }
               else if txtEmail.text?.isEmpty == true || isValid(email: mail) == false {
                          print("please write valid email ")
                      }
               else if txtLocation.text?.isEmpty == true {
                   print("please write your location salon ")
               }
               else if txtPass.text?.isEmpty == true {
                   print("please write your password ")
               }
               else if txtConfPass.text?.isEmpty == true || txtConfPass.text != txtPass.text {
                   print("please match password ")
               }
               else {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPass.text!){(user,error)in
                                  if error == nil{
                                      self.sendDatatoFirebase()
                                      print("Successuflly registred")
                                  }else{
                                      print("Faild")
                                  }
                }}}
    func sendDatatoFirebase() {
        let userId = Auth.auth().currentUser?.uid
        let customer = [
            "userid" : userId!,
            "username" : txtUsername.text!,
            "phoneNumber" : txtPhonenum.text!,
            "email" : txtEmail.text!,
            "location" : txtLocation.text!,
            "Role" : "Customer"
        ] as [String : Any]
        
        ref.child(userId!).setValue(customer)
    }

    @IBAction func btnLogin(_ sender: Any) {
        performSegue(withIdentifier: "loginC", sender: self)
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

extension UITextField{
      func addBottomSignCustomer() {
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
