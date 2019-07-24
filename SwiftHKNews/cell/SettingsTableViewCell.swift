//
//  SettingsTableViewCell.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/24.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var cacheSizeView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
