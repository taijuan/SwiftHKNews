//
//  VideoTableViewCell.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {


    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTime: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoSubject: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        logE(any: "awakeFromNib")
        self.videoView.setViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
