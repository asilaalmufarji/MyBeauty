//
//  CustomerProfileViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 11/21/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import SideMenu
import Firebase


class CustomerProfileViewController: UIViewController {
   var ref:DatabaseReference!
    @IBOutlet weak var viewC: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    @IBOutlet weak var imgC: UIImageView!
    var objCustomer = CustomerOB()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        if revealViewController() != nil {
            btnSideMenu.target = self.revealViewController()
            btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
        
        viewC.layer.cornerRadius = 20
        viewC.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        viewC.layer.borderWidth = 1.5
        
        imgC.layer.cornerRadius = 57
        imgC.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        imgC.layer.borderWidth = 1.5
        
        btn.layer.cornerRadius = 10
        ref = Database.database().reference()
            guard let username = UserDefaults.standard.object(forKey: "username") else {
                     return }
            self.txtUsername.text = username as? String
        
                 guard let location = UserDefaults.standard.object(forKey: "location") else { return
                        }
            self.txtLocation.text = location as? String
                 guard let phone = UserDefaults.standard.object(forKey: "phonenumber") else {
                     return
                 }
            self.txtPhone.text = phone as? String
       // view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        let name = txtUsername.text!
        let location = txtLocation.text!
        let num = txtPhone.text
        
               let userid = Auth.auth().currentUser?.uid
                //let phone = txtPhoneNum.text!
             //  let ownerId = Auth.auth().currentUser?.uid
               ref.child("User").child(userid!).child("username").setValue(name)
       ref.child("User").child(userid!).child("phoneNumber").setValue(num)
         ref.child("User").child(userid!).child("location").setValue(location)
                self.navigationController?.popViewController(animated: true)
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
