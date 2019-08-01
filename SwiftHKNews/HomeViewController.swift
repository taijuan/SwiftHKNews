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
        testStrings()
    }
    
    func createTabItem(name:String)->ESTabBarItem{
        let tabItem = ESTabBarItem(SpringBouncesContentView(),title: name, image: UIImage(named: "\(name)")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "\(name)_selected")?.withRenderingMode(.alwaysOriginal))
        return tabItem
    }
    
    func testStrings() {
        logE(any: Bundle.main.localizedString(forKey: "test", value: "", table: nil))
        logE(any: Bundle.main.localizedString(forKey: "test", value: "", table: "Main"))
        logE(any: NSLocalizedString("test", tableName: "Main", bundle: Bundle.main, value: "", comment: ""))
        logE(any: NSLocalizedString("news", comment: ""))
        
        logE(any: Bundle.main.localizedString(forKey: "focus", value: "", table: "Values"))
        logE(any: Bundle.main.localizedString(forKey: "news", value: "", table: "Localizable"))
    }
}

