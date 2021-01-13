//
//  SelectSalonViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/6/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SelectSalonViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var imgSalon: UIImageView!
    
    @IBOutlet weak var tblService: UITableView!
    @IBOutlet weak var lblSalon: UILabel!
    var objSalon = OwnerOB()
    var refService : DatabaseReference!
    var index = 0
    var arrService:[ServiceOB] = []
    var ref:DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        imgSalon.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        imgSalon.layer.borderWidth = 1
        imgSalon.layer.cornerRadius = 20
        tblService.delegate = self
         tblService.dataSource = self
         ref = Database.database().reference()
         lblSalon.text! = objSalon.salonname
         refService = Database.database().reference()
        self.FetchDataFromFirebase()
           //    let url = URL(string: objSalon.imageUrl)
             //  if let data = try? Data(contentsOf: url!){
             //    if let image = UIImage(data: data){
             //    DispatchQueue.main.async {
             //    self.imgSalon.image = image
              //    }
              //   }
                //     }

        // Do any additional setup after loading the view.
    }
    func FetchDataFromFirebase(){
    self.refService.child("Service").observe(.value){(snapshot) in
          if let data = snapshot.value as? NSDictionary{
              print(data)
              self.arrService.removeAll()
              for key in ((snapshot.value as AnyObject).allKeys)!{
                  print(key)
                  let obj = ServiceOB()
                  let service = data.value(forKey: key as! String) as! NSDictionary
                  obj.type = service.value(forKey: "type") as! String
                  obj.price = service.value(forKey: "price") as! String
                  obj.time = service.value(forKey: "time") as! String
                  obj.datails = service.value(forKey: "details") as! String
               //   let image = service.value(forKey: "ImageUrl") as! String
                  obj.imageUrl = service.value(forKey: "ImageUrl") as! String

                
                  self.arrService.append(obj)
              }
              self.tblService.reloadData()
          }
      }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrService.count
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "service") as! ServicechooseTableViewCell
        let obj = arrService[indexPath.row]
         cell.lblType.text! = obj.type
     //   cell.priceService.text! = obj.price
     //   cell.timeService.text! = obj.time
    //    cell.detailsService.text! = obj.datails
    
         //   let url = URL(string: obj.imageUrl)
          //     if let data = try? Data(contentsOf: url!){
         //   if let image = UIImage(data: data){
          //   DispatchQueue.main.async {
         //   cell.imageService.image = image
        
         return cell
            
           }
        
        
                  // return cell

        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "select", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SelectServiveViewController
        destination.objService = arrService[index]
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
