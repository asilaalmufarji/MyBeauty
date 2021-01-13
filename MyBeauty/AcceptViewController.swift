//
//  AcceptViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/5/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class AcceptViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblAccept: UITableView!
    var ref:DatabaseReference!
    var arrayOwner:[OwnerOB] = []
    override func viewDidLoad() {
               tblAccept.delegate = self
               tblAccept.dataSource = self
               ref = Database.database().reference()
               getData()
        fetchDataFromFireBase()
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true

        // Do any additional setup after loading the view.
    }
    
    func getData() {
    let userid = Auth.auth().currentUser?.uid
    ref.child("User").queryOrdered(byChild: "userid").queryEqual(toValue: userid).observe(.value){(snapshot) in
        if let data = snapshot.value as? NSDictionary{
            print(data)
            let userinfo = data.value(forKey: userid!) as! NSDictionary
            print(userinfo)
            let role = userinfo.value(forKey: "Role") as! String
           // let status = userinfo.value(forKey: "status") as! String
            //&& status == "accept"
            if role == "Owner" {
               print("successful")
                self.fetchDataFromFireBase()
             // self.performSegue(withIdentifier: "start", sender: self)
           }
        }
        }
    }
    func fetchDataFromFireBase(){
          ref.child("Salon").observe(.value){(snapshot) in
              if let data = snapshot.value as? NSDictionary{
                  print(data)
                  for key in ((snapshot.value as AnyObject).allKeys)!{
                      print(key)
                      let obj = OwnerOB()
                      let SalonDetails = data.value(forKey: key as! String) as! NSDictionary
                      obj.salonname = SalonDetails.value(forKey: "SalonName") as! String
                  //    obj.salonacount = SalonDetails.value(forKey: "AccountSalon") as! String
                  //    obj.email = SalonDetails.value(forKey: "email") as! String
                      self.arrayOwner.append(obj)
                  }
                  self.tblAccept.reloadData()
              }
          }
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOwner.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accept") as! AcceptTableViewCell
        let obj = arrayOwner[indexPath.row]
        cell.lblName.text! = obj.salonname
       // cell.lblAccount.text! = obj.salonacount
       // cell.lblEmail.text! = obj.email
        
        cell.img.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.img.layer.borderWidth = 1.5
        cell.img.layer.cornerRadius = 25
        return cell
        
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
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
