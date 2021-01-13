//
//  AddtoCartViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/6/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class AddtoCartViewController: UIViewController {

    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var priceService: UILabel!
    @IBOutlet weak var pricee: UILabel!
    @IBOutlet weak var salonname: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewAdd: UIView!
    var objService = ServiceOB()
    var objsaoln = OwnerOB()
     var index = 0
     var ref : DatabaseReference!
     var arrService:[ServiceOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
           ref = Database.database().reference()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        viewAdd.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        viewAdd.layer.borderWidth = 1.5
        viewAdd.layer.cornerRadius = 20
        btnSave.layer.cornerRadius = 15
        
        type.text! = objService.type
                  //  lblTime.text! = objService.time
                     price.text! = objService.price
                    salonname.text! = objsaoln.salonname
        ref = Database.database().reference().child("cart")
        // Do any additional setup after loading the view.
    }
    func sendDatatoFirebase() {
           let customerId = Auth.auth().currentUser?.uid
           let addtocartRef = self.ref!.childByAutoId()
           let addtocartId = addtocartRef.key
                   let addtocartData = [
                       "addtocartId" : addtocartId!,
                       "customerId" : customerId! ,
                       "type" : type.text!,
                       "price" : price.text!,
                       //"time" : ti.text!,
                     //  "date" : txtDate.text!,
                       "totalPrice" : total.text!,
                     //  "count" : txtcount.text!,
                   //    "staute" : "waiting to accepet reservation"
                       ] as [String : Any]
                   
           addtocartRef.setValue(addtocartData)
       }
    @IBAction func btnSave(_ sender: Any) {
        self.sendDatatoFirebase()
        print("sucess")
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
