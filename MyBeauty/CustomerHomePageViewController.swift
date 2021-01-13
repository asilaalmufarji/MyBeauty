//
//  CustomerHomePageViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/20/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class CustomerHomePageViewController: UIViewController {

    @IBOutlet weak var btnSideMenue: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController!.setNavigationBarHidden(true, animated: nil)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        
        
        if self.revealViewController() != nil {
            btnSideMenue.target = self.revealViewController()
            btnSideMenue.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
        // Do any additional setup after loading the view.
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
