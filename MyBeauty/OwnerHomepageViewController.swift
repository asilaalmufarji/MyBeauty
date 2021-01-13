//
//  OwnerHomepageViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 1/4/21.
//  Copyright © 2021 OJP12. All rights reserved.
//

import UIKit

class OwnerHomepageViewController: UIViewController {

    @IBOutlet weak var btnR: UIButton!
    @IBOutlet weak var btnAcc: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var home: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true

        home.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        home.layer.borderWidth = 1.5
        home.layer.cornerRadius = 15
         // cell.btnAccepte.layer.cornerRadius = 9
         // cell.btnRejecte.layer.cornerRadius = 9
          
        home.layer.shadowColor = UIColor.gray.cgColor
        home.layer.shadowOffset = CGSize(width: 2, height: 2 )
           home.layer.shadowOpacity = 0.8
          home.layer.shadowRadius = 4
          
          
         img.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
         img.layer.borderWidth = 1.5
         img.layer.cornerRadius = 30

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
