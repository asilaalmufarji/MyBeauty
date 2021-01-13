//
//  ListServicesViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/7/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import  Firebase
class ListServicesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tblServices: UITableView!
    var ref : DatabaseReference!
    var index = 0
    var arrayService:[ServiceOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
         tblServices.delegate = self
         tblServices.dataSource = self
         ref = Database.database().reference()
         FetchDataFromFirebase()
        // Do any additional setup after loading the view.
    }
    func FetchDataFromFirebase(){
        ref.child("Service").observe(.value){(snapshot) in
            if let data = snapshot.value as? NSDictionary{
                print(data)
                self.arrayService.removeAll()
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

                    self.arrayService.append(obj)
                }
                self.tblServices.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayService.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ServicesTableViewCell
        let obj = arrayService[indexPath.row]
        cell.txtType.text! = obj.type
   //     cell.txtPrice.text! = obj.price
  //      cell.txtTime.text! = obj.time
  //      cell.txtDetails.text! = obj.datails
        let url = URL(string: obj.imageUrl)
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data){
            DispatchQueue.main.async {
               cell.imgService.image = image
            }
        }
        }

        
        return cell
        
      }
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let objDelete = arrayService[indexPath.row]
            ref.child("Service").child(objDelete.serviceId).removeValue()
            arrayService.remove(at: indexPath.row)
            tblServices.deleteRows(at: [indexPath], with: .fade)
            tblServices.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "select", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let destination = segue.destination as! UpdateServiceViewController
     //   destination.objService = arrayService[index]
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
