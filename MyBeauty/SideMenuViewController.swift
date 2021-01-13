//
//  SideMenuViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/20/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SideMenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            let defaults = UserDefaults.standard
            //defaults.set(false, forKey: "isUserSignIn")
            
            defaults.removeObject(forKey: "isUserSignIn")
            try firebaseAuth.signOut()
            //         let login = LoginViewController()
            //          let loginNavigation = UINavigationController(rootViewController: login)
            //      self.present(loginNavigation, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            controller.modalPresentationStyle = .fullScreen
            
            self.present(controller, animated: true, completion: nil)
            
            
            print("success")
            //self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
