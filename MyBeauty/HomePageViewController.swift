//
//  HomePageViewController.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit
import SideMenu
import Firebase
class HomePageViewController: UIViewController , MenuControllerDelegate {
 
    
    
    @IBOutlet weak var AdvCollectionView: UICollectionView!
    private var sideMenu: SideMenuNavigationController?
    private let profileController = CustomerProfileViewController()

    var ref:DatabaseReference!
    var arrayOwner:[OwnerOB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController!.navigationBar.shadowImage = UIImage()
    self.navigationController!.navigationBar.isTranslucent = true
      //  AdvCollectionView.delegate = self
      //  AdvCollectionView.dataSource = self
       
        
        // menu
        let menu =  MenuController(with: sideMenuItem.allCases)
        menu.deleget = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        // Do any additional setup after loading the view.
        addChildControllers()
    }
    private func addChildControllers(){
      addChild(profileController)
       view.addSubview(profileController.view)
        profileController.view.frame = view.bounds
        
      profileController.didMove(toParent: self)
        
        profileController.view.isHidden = true
    }

    @IBAction func didTabMenuButton() {
        present(sideMenu!, animated: true)
    }
    func didSelectMenuItem(named: sideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            self?.title = named.rawValue
            switch named {
            case .home:
                 self?.profileController.view.isHidden = true
            case .profile:
                self?.profileController.view.isHidden = false
                
            }
            
          //  if named == "Home" {
             //   self?.profileController.view.isHidden = true
         //   }else if named == "profile" {
         //       self?.profileController.view.isHidden = false
         //   }
        })
       }
    

     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AdvCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdvHomeCollectionViewCell
        return cell
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


