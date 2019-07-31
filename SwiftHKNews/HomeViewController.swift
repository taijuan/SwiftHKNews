//
//  HomeViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class HomeViewController: ESTabBarController {
    override var shouldAutorotate: Bool{
        get {
            return false
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let news = NewsViewController(isNews: true)
        news.tabBarItem = createTabItem(name: "news")
        let focus = NewsViewController(isNews: false)
        focus.tabBarItem = createTabItem(name: "focus")
        let epaper = EPaperViewController()
        epaper.tabBarItem = createTabItem(name: "epaper")
        let video = VideoViewController()
        video.tabBarItem = createTabItem(name: "video")
        let me = MineViewController()
        me.tabBarItem = createTabItem(name: "me")
        self.viewControllers = [news,focus,epaper,video,me]
        self.tabBar.frame = CGRect(x: 0, y: height()-statusHeight, width: width(), height: tabBarHeight()+bottom())
        self.tabBar.backgroundColor = .white
    }
    
    func createTabItem(name:String)->ESTabBarItem{
        let tabItem = ESTabBarItem(SpringBouncesContentView(),title: name, image: UIImage(named: "\(name)")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "\(name)_selected")?.withRenderingMode(.alwaysOriginal))
        return tabItem
    }
    
}

