//
//  TopViewController.swift
//  MyBeauty
//
//  Created by OJP11 on 11/10/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var offers: UIView!
    @IBOutlet weak var Adv: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
     func showView1() {
                Adv.isHidden = false
                offers.isHidden = true
            }

            func showView2() {
                Adv.isHidden = true
                offers.isHidden = false
            }

            guard let segmentedControl = sender as?
                UISegmentedControl else { return }
            if segmentedControl.selectedSegmentIndex == 0 {
                showView1()

            }
                else {
                    showView2()
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
