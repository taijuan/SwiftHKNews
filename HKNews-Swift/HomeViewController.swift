//
//  HomeViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [
            NewsViewController(isNews: true),
            NewsViewController(isNews: false),
            PaperViewController(),
            VideoViewController(),
            MineViewController()
        ]
        logE(any: self.view.bounds)
    }
}
