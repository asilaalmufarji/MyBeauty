//
//  LoginViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 11/12/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        btn.layer.cornerRadius = 8
        self.txtEmail.addBottimBorder()
        self.txtPass.addBottimBorder()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
        //   self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let mail = txtEmail.text!
        if txtEmail.text?.isEmpty == true  && txtPass.text?.isEmpty == true {
            print("fill all blank")
        }
        else if txtEmail.text?.isEmpty == true || isValid(email: mail) == false {
            print("please write valid email ")
        }
        else if txtPass.text?.isEmpty == true {
            print("please write correct password ")
        }
        else if self.txtEmail.text == "asila@gmail.com" && self.txtPass.text == "123456" {
            
            self.performSegue(withIdentifier: "admin", sender: nil)
        }
            
        else {
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPass.text!){(user,error)in
                
                if error == nil {
                    self.getData()
                    print("success")
                }
                else {
                    print("faild")
                }
            }
        }
    }
    
    func getData() {
        let userid = Auth.auth().currentUser?.uid
        ref.child("User").queryOrdered(byChild: "userid").queryEqual(toValue: userid).observe(.value){(snapshot) in
            if let data = snapshot.value as? NSDictionary{
                print(data)
                let userinfo = data.value(forKey: userid!) as! NSDictionary
                print(userinfo)
                let role = userinfo.value(forKey: "Role") as! String
                if role == "Owner"{
                    
                    guard let username = userinfo.value(forKey: "username") as? String else { return }
                    
                    let salonname = userinfo.value(forKey: "SalonName") as! String
                    let email = userinfo.value(forKey: "email") as! String
                    let account = userinfo.value(forKey:"AccountSalon") as! String
                    let status = userinfo.value(forKey: "status") as! String
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(salonname, forKey: "SalonName")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(account, forKey: "AccountSalon")
                    if status == "accept"{
                        print("successful")
                        self.performSegue(withIdentifier: "start", sender: self)
                    }
                    else if status == "pending" {
                        //print("success owner")
                        //  print("please waiting after accept")
                        let alert = UIAlertController(title: "Error", message: "Please wait while you are accepted into the app", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else if status == "reject" {
                        //print("success owner")
                        //  print("please waiting after accept")
                        let alert = UIAlertController(title: "Error", message: "Sorry Can't access into the app", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                else if role == "Customer" {
                    let username = userinfo.value(forKey: "username") as! String
                    let email = userinfo.value(forKey: "email") as! String
                    let location = userinfo.value(forKey: "location") as! String
                    let phone = userinfo.value(forKey: "phoneNumber") as! String
                    UserDefaults.standard.set(location, forKey: "location")
                    UserDefaults.standard.set(phone, forKey: "phoneNumber")
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(email, forKey: "email")
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainHomeViewController")
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                    
                    //self.performSegue(withIdentifier: "customer", sender: self)
                    
                }
                else {
                    print("user dont have account")
                } }} }
    
    
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
    func addBottimBorder() {
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


