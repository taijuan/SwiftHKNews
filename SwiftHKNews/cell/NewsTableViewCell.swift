//
//  NewsTableViewCell.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .default
        self.newsView.setViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
