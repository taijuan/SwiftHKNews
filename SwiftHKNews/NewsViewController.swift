//
//  NewsViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import JXSegmentedView

class NewsViewController: BaseViewController {
    private var isNews:Bool = true
    private var tabNames:Array<String> = []
    private var codes:Array<String> = []
    private let segmentedView:JXSegmentedView = JXSegmentedView()
    private lazy var segmentedListContainerView : JXSegmentedListContainerView = JXSegmentedListContainerView(dataSource: self)
    private lazy var dataSource:JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = tabNames
        dataSource.reloadData(selectedIndex: 0)
        return dataSource
    }()
    
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
    
    override func viewDidLayoutSubviews() {
        var y = statusHeight+toolBarHeight()
        segmentedView.frame = CGRect(x: 0, y: y, width: width(), height: pageTabBarHeight())
        y += pageTabBarHeight()
        let h = height()-y-tabBarHeight()-bottom()
        segmentedListContainerView.frame =  CGRect(x: 0,y: y,width: width(),height: h)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.isIndicatorConvertToItemFrameEnabled = true
        indicator.indicatorHeight = 30
        segmentedView.indicators = [indicator]
        segmentedView.dataSource = dataSource
        segmentedView.delegate = self
        self.view.addSubview(segmentedView)
        self.segmentedView.contentScrollView = segmentedListContainerView.scrollView
        segmentedListContainerView.didAppearPercent = 0.01
        self.view.addSubview(segmentedListContainerView)
        if isNews {
            self.setHeaderTitleBar(title: "News")
        }else{
            self.setHeaderTitleBar(title: "Focus")
        }
    }
}

extension NewsViewController:JXSegmentedListContainerViewDataSource{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.dataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return NewsChildViewController(code: codes[index])
    }
}

extension NewsViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        self.segmentedListContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        self.segmentedListContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}
