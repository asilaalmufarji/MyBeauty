//
//  AdminEditProfileViewController.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class AdminEditProfileViewController: UIViewController {
 var ref:DatabaseReference!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtSalonAccount: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var imgOwner: UIImageView!
    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var btn: UIButton!
    var objOwner = OwnerOB()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        imgOwner.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
             imgOwner.layer.borderWidth = 1.2
             imgOwner.layer.cornerRadius = 62
        imgOwner.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
             
             vieww.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
             vieww.layer.borderWidth = 1.2
             vieww.layer.cornerRadius = 15
        
        btn.layer.cornerRadius = 10
        ref = Database.database().reference()
        guard let username = UserDefaults.standard.object(forKey: "username") else {
                 return }
        self.txtUsername.text = username as? String
    
             guard let salonacount = UserDefaults.standard.object(forKey: "AccountSalon") else { return
                    }
        self.txtSalonAccount.text = salonacount as? String
             guard let phone = UserDefaults.standard.object(forKey: "phonenumber") else {
                 return
             }
        self.txtPhoneNum.text = phone as? String
        
     
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        let name = txtUsername.text!
         let salonaccount = txtSalonAccount.text!
        let ownerid = Auth.auth().currentUser?.uid
         //let phone = txtPhoneNum.text!
      //  let ownerId = Auth.auth().currentUser?.uid
        ref.child("Owner").child(ownerid!).child("username").setValue(name)
        ref.child("Owner").child(ownerid!).child("AccountSalon").setValue(salonaccount)
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
