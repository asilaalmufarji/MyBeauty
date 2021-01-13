//
//  OffersViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 11/4/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class OffersViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtType: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    //database refrence
     var ref:DatabaseReference!
    // var storageRef : StorageReference!
     //storage
     var storageRef : StorageReference!
     var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        imagePicker.delegate = self
        ref = Database.database().reference().child("Offers")

        self.txtType.addBorderOffers()
        self.txtDate.addBorderOffers()
        self.txtDescription.addBorderOffers()
        
        txtType.frame.size.height = 50
        txtDescription.frame.size.height = 90
        txtDate.frame.size.height = 50
        
        imgOffer.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        imgOffer.layer.borderWidth = 1.2
        imgOffer.layer.cornerRadius = 15
        
        btnSave.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func picImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.allowsEditing = false
                        self.present(imagePicker,animated: true , completion: nil)
                    }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                  let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                  self.imgOffer.image = selectedImage
                  self.dismiss(animated: true, completion: nil)
              }
    func sendDatatoFirebase(ImageUrl : String) {
           let ownerId = Auth.auth().currentUser?.uid
           let newOffersRef = self.ref!.childByAutoId()
           let newOffersId = newOffersRef.key
                   let newOffersData = [
                       "offersId" : newOffersId! ,
                       "ownerId" : ownerId! ,
                       "Offerstype" : txtType.text!,
                       "Date" : txtDate.text!,
                       "description" : txtDescription.text!,
                       "ImageUrl" : ImageUrl
                       ] as [String : Any]
                   
           newOffersRef.setValue(newOffersData)
       }
    @IBAction func btnSave(_ sender: Any) {
        if txtType.text?.isEmpty == true  && txtDescription.text?.isEmpty == true && txtDate.text?.isEmpty == true {
                          print("fill all blank")
                      }
                      else if txtType.text?.isEmpty == true {
                          print("please write type of offers ")
                      }
                      else if txtDescription.text?.isEmpty == true {
                   print("please write Description")}
               else if txtDate.text?.isEmpty == true {
                   print("please write Duration date")
               }
               else {
        storageRef = Storage.storage().reference().child("OffersImage")
                                  let imageName = UUID().uuidString + ".jpg"
                                  let imagesRefrence = storageRef.child(imageName)
                                  let imageData = self.imgOffer.image!.pngData()
                                  let metaData = StorageMetadata()
                                  metaData.contentType = "image/jpg"
                                  imagesRefrence.putData(imageData! , metadata: metaData){
                                      (metadata , error) in
                                      guard metadata != nil else {
                                          print("Error :\(String(describing: error?.localizedDescription))")
                                          return
                                      }
                                      imagesRefrence.downloadURL(completion: {
                                          (url,error) in
                                          if error != nil {
                                              print("Faild to download url: ", error!)
                                              return
                                          } else {
                                            let imgURL = (url?.absoluteString)!
                                            self.sendDatatoFirebase(ImageUrl: imgURL)
                                              
                                          }
                                      })
                                  }
                          print("succes")
                      let alert = UIAlertController(title: "successfully", message: "new Offer saved succesfully", preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in
                          self.performSegue(withIdentifier: "next", sender: nil)
                      }))
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

 extension UITextField{
      func addBorderOffers() {
       //    let bottomLine = CALayer()
        self.borderStyle = .none
         self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
          // bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        //bottomLine.backgroundColor = UIColor.white.cgColor
      //  borderStyle = .none
      //  bottomLine.borderColor = UIColor.black.cgColor
          // txtpass.borderStyle = UITextField.BorderStyle.none
       // self.layer.addSublayer(bottomLine)
       }
}
