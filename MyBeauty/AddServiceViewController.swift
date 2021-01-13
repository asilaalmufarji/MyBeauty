//
//  AddServiceViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 10/23/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import Firebase
class AddServiceViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var txtDetails: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var txtservicetype: UITextField!
    @IBOutlet weak var txtservicename: UITextField!
    
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
               ref = Database.database().reference().child("Service")
        // Do any additional setup after loading the view.
        imgService.layer.borderColor = #colorLiteral(red: 0.9820607305, green: 0.3886229098, blue: 0.5119735599, alpha: 1)
        imgService.layer.cornerRadius = 15
        imgService.layer.borderWidth = 1.2
        self.txtTime.addBorder()
        self.txtservicename.addBorder()
        self.txtPrice.addBorder()
        self.txtDetails.addBorder()
        self.txtservicetype.addBorder()
        self.txtservicetype.frame.size.height = 45
        self.txtservicename.frame.size.height = 45
        self.txtPrice.frame.size.height = 45
        self.txtTime.frame.size.height = 45
        self.txtDetails.frame.size.height = 70
        
     //  imgService.layer.shadowColor = UIColor.gray.cgColor
       //  imgService.layer.shadowOffset = CGSize(width: -2, height: -2 )
      //  imgService.layer.shadowOpacity = 0.8
        
        
        btnSave.layer.cornerRadius = 12
        
        
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
              self.imgService.image = selectedImage
              self.dismiss(animated: true, completion: nil)
          }
    func sendDatatoFirebase(ImageUrl : String) {
        let ownerId = Auth.auth().currentUser?.uid
        let newServiceRef = self.ref!.childByAutoId()
        let newServiceId = newServiceRef.key
                let newServiceData = [
                    "serviceId" : newServiceId! ,
                    "ownerId" : ownerId! ,
                    "serviceName" : txtservicename.text!,
                    "type" : txtservicetype.text!,
                    "price" : txtPrice.text!,
                    "time" : txtTime.text!,
                    "details" : txtDetails.text!,
                    "ImageUrl" : ImageUrl
                    ] as [String : Any]
                
        newServiceRef.setValue(newServiceData)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if txtservicename.text?.isEmpty == true  && txtservicetype.text?.isEmpty == true && txtPrice.text?.isEmpty == true && txtTime.text?.isEmpty == true {  print("please fill all blank")
        }
        else if txtservicename.text?.isEmpty == true  {
            print("please write service name")
        }
        else if txtservicetype.text?.isEmpty == true  {
                   print("please write service Type")
               }
        else if txtPrice.text?.isEmpty == true  {
                         print("please write price")
                     }
        else if txtTime.text?.isEmpty == true  {
                               print("please write time")
                           }
        else {
        storageRef = Storage.storage().reference().child("serviceImage")
                           let imageName = UUID().uuidString + ".jpg"
                           let imagesRefrence = storageRef.child(imageName)
                           let imageData = self.imgService.image!.pngData()
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
                   print("success")
               let alert = UIAlertController(title: "successfully", message: "new service saved succesfully", preferredStyle: UIAlertController.Style.alert)
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
      func addBorder() {
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
