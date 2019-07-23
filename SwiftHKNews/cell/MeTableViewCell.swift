//
//  MeTableViewCell.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/15.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
