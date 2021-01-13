//
//  CartViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/30/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class CartViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
 
    

    @IBOutlet weak var tblCart: UITableView!
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var viewCart: UIView!
    var ref:DatabaseReference!
   var refCart : DatabaseReference!
    var arrayservice:[ServiceOB] = []
    override func viewDidLoad() {
        
        ref = Database.database().reference()
               fetchDataFromFireBase()
        refCart = Database.database().reference().child("reservation")
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        if self.revealViewController() != nil {
                  btnSideMenu.target = self.revealViewController()
                  btnSideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
                  self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
              }
        
//        viewCart.layer.cornerRadius = 20
  //      viewCart.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
 //       viewCart.layer.borderWidth = 1.5
        
   //     img.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
   //     img.layer.borderWidth = 1.5
     //   img.layer.cornerRadius = 23
    //    // Do any additional setup after loading the view.
    }
    func fetchDataFromFireBase(){
           arrayservice = []
           ref.child("cart").observe(.value){(snapshot) in
               if let data = snapshot.value as? NSDictionary{
                 //  print(data)
                   for key in ((snapshot.value as AnyObject).allKeys)!{
                       print(key)
                       let obj = ServiceOB()
                       let CartDetails = data.value(forKey: key as! String) as! NSDictionary
                       obj.type = CartDetails.value(forKey: "type") as! String
                       obj.price = CartDetails.value(forKey: "price") as! String
//                       obj.userid = CartDetails.value(forKey: "customerid") as! String
                      // obj.addtocartid = CartDetails.value(forKey: "addtocartId") as! String
                       self.arrayservice.append(obj)
                   }
                   self.tblCart.reloadData()
               }
           }
    }
    func sendDatatoFirebase() {
        let customerId = Auth.auth().currentUser?.uid
        let addtocartRef = self.ref!.childByAutoId()
        let addtocartId = addtocartRef.key
                let addtocartData = [
                    "addtocartId" : addtocartId!,
                    "customerId" : customerId! ,
                   // "type" : type.text!,
                  //  "price" : price.text!,
                    //"time" : ti.text!,
                  //  "date" : txtDate.text!,
                   // "totalPrice" : total.text!,
                  //  "count" : txtcount.text!,
                   "staute" : "waiting to accepet reservation"
                    ] as [String : Any]
                
        addtocartRef.setValue(addtocartData)
    }
    @objc func Send(sender: UIButton) {
     sendDatatoFirebase()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CartTableViewCell
        let obj = arrayservice [indexPath.row]
     //   cell.type.text! = obj.type
        cell.price.text! = obj.price
       // cell.phone.text! = obj.p
        
        cell.btnSend.tag = indexPath.row
        cell.btnSend.addTarget(self, action: #selector(Send), for: .touchUpInside)
        cell.btnSend.layer.cornerRadius = 1.5

        //
        cell.btnSend.layer.cornerRadius = 9
        
        
        //let colorB = UIColor(red: 249, green: 101, blue: 133, alpha: 1)
      //  cell.accView.layer.borderColor =
        cell.view.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        cell.view.layer.borderWidth = 1.5
        
        cell.view.layer.cornerRadius = 15
        
        cell.view.layer.shadowColor = UIColor.gray.cgColor
        cell.view.layer.shadowOffset = CGSize(width: 2, height: 2 )
        cell.view.layer.shadowOpacity = 0.8
        cell.view.layer.shadowRadius = 4
        
        
        cell.img.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.img.layer.borderWidth = 1.5
        cell.img.layer.cornerRadius = 30
        
        
        return cell
        
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayservice.count
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
