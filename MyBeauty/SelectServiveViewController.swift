//
//  SelectServiveViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/6/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SelectServiveViewController: UIViewController {

    @IBOutlet weak var vieww: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgService: UIImageView!
    var objService = ServiceOB()
    var index = 0
    var ref : DatabaseReference!
    var arrService:[ServiceOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        ref = Database.database().reference()
        vieww.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        vieww.layer.cornerRadius = 20
        vieww.layer.borderWidth = 1.5
        imgService.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
         imgService.layer.cornerRadius = 20
         imgService.layer.borderWidth = 1.5
               lblType.text! = objService.type
             //  lblTime.text! = objService.time
                lblprice.text! = objService.price
               lblDetails.text! = objService.datails
               let url = URL(string: objService.imageUrl)
                             if let data = try? Data(contentsOf: url!){
                                 if let image = UIImage(data: data){
                                  DispatchQueue.main.async {
                                  self.imgService.image = image
                                 }
                             }
                             }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        performSegue(withIdentifier: "add", sender: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destination = segue.destination as! AddtoCartViewController
       // destination.objService = arrService[index]
       // destination.objService = arrayService[index]
      //  destination.type = self..text!
      //  destination.price = lblPrice.text!
     //   destination.price = lblPrice.Int!
        
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
