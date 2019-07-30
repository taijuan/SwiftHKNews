//
//  TableViewUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/8.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import RxSwift
import WebKit

extension UITableView {
    func registerXib(xib:String){
        let nib = UINib(nibName: xib, bundle: nil)
        self.register(nib, forCellReuseIdentifier: xib)
    }
    
    func getCell<T>(xib:String,indexPath: IndexPath)->T{
        return self.dequeueReusableCell(withIdentifier: xib, for: indexPath) as! T
    }
    
    //刷新UI
    func registerHeader(action:@escaping ()->Void){
        self.mj_header = MJRefreshNormalHeader()
        self.mj_header.isAutomaticallyChangeAlpha = true
        self.mj_header.refreshingBlock = {
            action()
        }
//        self.mj_header.beginRefreshing()
    }
    
    //加载更多UI
    func registerFooter(action:@escaping ()->Void){
        self.mj_footer = MJRefreshAutoNormalFooter()
        self.mj_footer.refreshingBlock = {
            action()
        }
    }
}


extension UIView {
    //设置UIVIew，UIImageView等的边框，圆角，阴影
    func setViewShadow(
        borderWidth:CGFloat = 1,//边框宽度
        borderColor:UIColor = UIColor.lightGray,//边框颜色
        cornerRadius : CGFloat = 4,//圆角半径
        shadowColor:UIColor = UIColor.lightGray,//阴影颜色
        shadowOffset:CGSize = CGSize(width: 8, height: 8),//隐隐偏移量
        shadowRadius:CGFloat = 8//边框圆角和阴影半径
        ) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = true
    }
    
    //设置UIView渐变背景
    func setGradientLayer(
        startColor:UIColor = lightBlue,
        //        centerColor:UIColor = UIColor(hex: "#0e65d7"),
        endColor:UIColor = blue
        ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.addSublayer(gradientLayer)
    }
}


extension WKWebView {
    convenience init(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat) {
        let config = WKWebViewConfiguration()
        config.preferences.minimumFontSize = 8
        let frame = CGRect(x: x, y: y, width: width, height: height)
        self.init(frame: frame, configuration: config)
    }
}
