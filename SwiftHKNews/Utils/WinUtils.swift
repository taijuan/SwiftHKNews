//
//  WinUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import MJRefresh

//屏幕density 比@2x=2，@3x=3
let density = UIScreen.main.scale

//状态栏高度
let statusHeight = UIApplication.shared.statusBarFrame.size.height
//屏幕宽度
func width() -> CGFloat {
    return UIScreen.main.bounds.size.width
}
//屏幕高度
func height() -> CGFloat {
    return UIScreen.main.bounds.size.height
}
//标题栏高度
func toolBarHeight() ->CGFloat{
    return 48
}
//新闻栏目UI高度
func pageTabBarHeight()->CGFloat{
    return 44
}
//主页底部TabBar高度
func tabBarHeight() ->CGFloat{
    return 48
}
//Ios底部safeArea高度
func bottom() -> CGFloat{
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        let bottom = window?.safeAreaInsets.bottom ?? 0
        return bottom
    } else {
        return 0
    }
}

func refreshHeight()->CGFloat{
    return MJRefreshHeaderHeight
}
