//
//  SalonAcceptenceViewController.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SalonAcceptenceViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
 
    

    @IBOutlet weak var tblSalonAccepte: UITableView!
    var ref:DatabaseReference!
    var arrayOwner:[OwnerOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        tblSalonAccepte.delegate = self
        tblSalonAccepte.dataSource = self
        ref = Database.database().reference()
        fetchDataFromFireBase()
        // Do any additional setup after loading the view.
    }
    @objc func Accept(sender: UIButton) {
        let tStrSalonID:String =  arrayOwner[sender.tag].salonid
        ref.child("Salon").child(tStrSalonID).child("status").setValue("accept")
        let tStrOwnerID:String =  arrayOwner[sender.tag].userid
        ref.child("User").child(tStrOwnerID).child("status").setValue("accept")
    }
    @objc func Reject(sender: UIButton) {
        let tStrsalonId:String = arrayOwner[sender.tag].salonid
        ref.child("Salon").child(tStrsalonId).child("status").setValue("reject")
        let tStrownerId:String = arrayOwner[sender.tag].userid
        ref.child("User").child(tStrownerId).child("status").setValue("reject")
    }
    
    func fetchDataFromFireBase(){
        arrayOwner = []
        ref.child("Salon").observe(.value){(snapshot) in
            if let data = snapshot.value as? NSDictionary{
              //  print(data)
                for key in ((snapshot.value as AnyObject).allKeys)!{
                    print(key)
                    let obj = OwnerOB()
                    let SalonDetails = data.value(forKey: key as! String) as! NSDictionary
                    obj.salonname = SalonDetails.value(forKey: "SalonName") as! String
                    obj.salonacount = SalonDetails.value(forKey: "AccountSalon") as! String
                    obj.email = SalonDetails.value(forKey: "email") as! String
                    obj.userid = SalonDetails.value(forKey: "userid") as! String
                    obj.salonid = SalonDetails.value(forKey: "salonId") as! String
                    self.arrayOwner.append(obj)
                }
                self.tblSalonAccepte.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOwner.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SalonAccepteTableViewCell
        let obj = arrayOwner[indexPath.row]
        cell.lblName.text! = obj.salonname
        cell.lblAccount.text! = obj.salonacount
        cell.lblEmail.text! = obj.email
        
        cell.btnAccepte.tag = indexPath.row
        cell.btnAccepte.addTarget(self, action: #selector(Accept), for: .touchUpInside)
        cell.btnAccepte.layer.cornerRadius = 1.5
        
        cell.btnRejecte.tag = indexPath.row
        cell.btnRejecte.addTarget(self, action: #selector(Reject), for: .touchUpInside)
        cell.btnRejecte.layer.cornerRadius = 1.5
      //cell.btnAccepte.addTarget(self, action: "print", for: .TouchUpInsaide)

        //
        cell.btnAccepte.layer.cornerRadius = 9
        cell.btnRejecte.layer.cornerRadius = 9
        
        //let colorB = UIColor(red: 249, green: 101, blue: 133, alpha: 1)
      //  cell.accView.layer.borderColor =
        cell.accView.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        cell.accView.layer.borderWidth = 1.5
        
        cell.accView.layer.cornerRadius = 15
        
        cell.accView.layer.shadowColor = UIColor.gray.cgColor
        cell.accView.layer.shadowOffset = CGSize(width: 2, height: 2 )
        cell.accView.layer.shadowOpacity = 0.8
        cell.accView.layer.shadowRadius = 4
        
        
        cell.imgSalon.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.imgSalon.layer.borderWidth = 1.5
        cell.imgSalon.layer.cornerRadius = 30
        
        
        return cell
        
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
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
