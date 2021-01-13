//
//  SalonListTableViewCell.swift
//  MyBeauty
//
//  Created by OJP11 on 11/9/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class SalonListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSalon: UIImageView!
    @IBOutlet weak var lblSalon: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
