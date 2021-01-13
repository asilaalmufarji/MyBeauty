//
//  SalonListViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 11/9/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SalonListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate   {
   var index = 0
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!
    @IBOutlet weak var tblSalonList: UITableView!
    var ref:DatabaseReference!
       var arrayOwner:[OwnerOB] = []
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
        
       tblSalonList.delegate = self
       tblSalonList.dataSource = self
               ref = Database.database().reference()
              fetchDataFromFireBase()

        // Do any additional setup after loading the view.
    }
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOwner.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "list") as! SalonListTableViewCell
               let obj = arrayOwner[indexPath.row]
               cell.lblSalon.text! = obj.salonname
        
        cell.imgSalon.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.imgSalon.layer.borderWidth =  1.5
        cell.imgSalon.layer.cornerRadius = 32
               return cell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
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
                 //   obj.salonacount = SalonDetails.value(forKey: "AccountSalon") as! String
                 //   obj.email = SalonDetails.value(forKey: "email") as! String
                 //   obj.userid = SalonDetails.value(forKey: "userid") as! String
                    
                    self.arrayOwner.append(obj)
                }
                self.tblSalonList.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "choose", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destination = segue.destination as! SelectSalonViewController
     destination.objSalon = arrayOwner[index]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
/ Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
