//
//  VideoHeaderTableViewCell.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/16.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class VideoHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var videoHeaderView: UIView!
    @IBOutlet weak var videoHeaderTitle: UILabel!
    @IBOutlet weak var videoHeaderContent: UILabel!
    @IBOutlet weak var videoHeaderSubject: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.videoHeaderView.setViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
