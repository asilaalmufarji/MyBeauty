//
//  ReservationViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/28/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    @IBOutlet weak var tblReservation: UITableView!
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true

        if self.revealViewController() != nil {
                  btnSideMenu.target = self.revealViewController()
                  btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
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
