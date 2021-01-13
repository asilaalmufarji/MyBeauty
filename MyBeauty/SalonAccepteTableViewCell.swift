//
//  SalonAccepteTableViewCell.swift
//  MyBeauty
//
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func cell(tag: String)
    
}

class SalonAccepteTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSalon: UIImageView!
    @IBOutlet weak var accView: UIView!
    @IBOutlet weak var btnRejecte: UIButton!
    @IBOutlet weak var btnAccepte: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnAccepte(_ sender: Any) {
    }
    @IBAction func btnRejecte(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
