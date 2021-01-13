//
//  Approval ReservationViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 1/5/21.
//  Copyright © 2021 OJP12. All rights reserved.
//

import UIKit

class Approval_ReservationViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var app: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        app.layer.cornerRadius = 15
        app.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        app.layer.borderWidth = 1.2
        
        img.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        img.layer.cornerRadius = 30
        img.layer.borderWidth = 1.2
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
