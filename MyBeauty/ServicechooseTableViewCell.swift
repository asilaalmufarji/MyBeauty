//
//  ServicechooseTableViewCell.swift
//  MyBeauty
//
//  Created by OJP11 on 12/6/20.
//  Copyright © 2020 OJP12. All rights reserved.
//

import UIKit

class ServicechooseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
