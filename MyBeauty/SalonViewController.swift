//
//  SalonViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 12/4/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class SalonViewController: UIViewController  , UICollectionViewDataSource , UICollectionViewDelegate {
   
    

    @IBOutlet weak var SalonCollectionView: UICollectionView!
    var ref:DatabaseReference!
    var test = ["1,2,3"]
    var arraySalon:[OwnerOB] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        SalonCollectionView.delegate = self
        SalonCollectionView.dataSource = self
        ref = Database.database().reference()
        fetchDataFromFireBase()
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return test.count
       }
    
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "salon", for: indexPath) as! SalonCollectionViewCell
        cell.lblSalon.text! = test[indexPath.row]
               //let obj = arraySalon[indexPath.row]
            //   cell.lblSalon.text! = obj.salonname
      //  let url = URL(string: obj.imageUrl)
         //          if let data = try? Data(contentsOf: url!){
         //         if let image = UIImage(data: data){
          //              DispatchQueue.main.async {
          //          cell.imgSalon.image = image
            //       }}}
              // cell.imgSalon.image = obj.imageSalon
                return cell
           
       }
    func fetchDataFromFireBase(){
        self.ref.child("Salon").observe(.value){(snapshot) in
        if let data = snapshot.value as? NSDictionary{
            print(data)
            self.arraySalon.removeAll()
            for key in ((snapshot.value as AnyObject).allKeys)!{
                print(key)
                let obj = OwnerOB()
                let SalonDetails = data.value(forKey: key as! String) as! NSDictionary
                obj.salonname = SalonDetails.value(forKey: "SalonName") as! String
              //  obj.imageUrl = SalonDetails.value(forKey: "ImageUrl") as! String
                
                self.arraySalon.append(obj)
            }
            self.SalonCollectionView.reloadData()
        }
    }
    
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
