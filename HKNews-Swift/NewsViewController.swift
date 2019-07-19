//
//  NewsViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import DNSPageView

class NewsViewController: UIViewController {
    private var isNews:Bool = true
    private var tabNames:Array<String> = []
    private var codes:Array<String> = []
    init(isNews:Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isNews = isNews
        if isNews {
            tabNames = ["HOME","HONG KONG","NATION","ASIA","WORLD","BUSINESS","DATA","SPORTS"]
            codes = ["home","hong_kong","nation","asia","world","business","data","sports"]
        }else{
            tabNames = ["LIFE & ART","LEADERS","OFFBEAT HK","IN-DEPTH CHINA","EYE ON ASIA","QUIRKY","PHOTO"]
            codes = ["life_art","leaders","offbeat_hk","in_depth_china","eye_on_asia","quirky","photo"]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pageViewManager: DNSPageViewManager = {
        // 创建DNSPageStyle，设置样式
        self.view.backgroundColor = UIColor.white
        let style = DNSPageStyle()
        style.isShowBottomLine = true
        style.isTitleViewScrollEnabled = true
        style.titleViewBackgroundColor = UIColor.clear
        style.contentViewBackgroundColor = UIColor.clear
        style.titleMargin = 16
        
        // 创建每一页对应的controller
        let childViewControllers: [UIViewController] = self.codes.map { code -> UIViewController in
            let controller = NewsChildViewController(code: code)
            addChild(controller)
            return controller
        }
        
        return DNSPageViewManager(style: style, titles: self.tabNames, childViewControllers: childViewControllers)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        var y = statusHeight+toolBarHeight()
        pageViewManager.titleView.frame = CGRect(x: 8, y: y, width: width()-16, height: pageTabBarHeight())
        self.view.addSubview(pageViewManager.titleView)
        y += pageTabBarHeight()
        let h = height()-y-tabBarHeight()-bottom()
        pageViewManager.contentView.frame = CGRect(x: 0,y: y,width: width(),height: h)
        logE(any: pageViewManager.contentView.frame)
        self.view.addSubview(pageViewManager.contentView)
        if isNews {
            self.setHeaderTitleBar(title: "News")
        }else{
            self.setHeaderTitleBar(title: "Focus")
        }
    }
}
