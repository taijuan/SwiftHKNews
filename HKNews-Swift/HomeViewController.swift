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
        let news = NewsViewController(isNews: true)
        news.tabBarItem.setTabItem(name: "news")
        let focus = NewsViewController(isNews: false)
        focus.tabBarItem.setTabItem(name: "focus")
        let epaper = PaperViewController()
        epaper.tabBarItem.setTabItem(name: "epaper")
        let video = VideoViewController()
        video.tabBarItem.setTabItem(name: "video")
        let me = MineViewController()
        me.tabBarItem.setTabItem(name: "me")
        self.viewControllers = [news,focus,epaper,video,me]
        logE(any: self.view.bounds)
    }
}
