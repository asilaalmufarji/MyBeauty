//
//  ServicesTableViewCell.swift
//  MyBeauty
//
//  Created by OJP11 on 12/7/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var txtDetails: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
