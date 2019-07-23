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

extension UIViewController {
    func setHeaderTitleBar(title:String = "Video"){
        //设置标题栏背景
        let  headerBackgroundView = UIView()
        headerBackgroundView.frame = CGRect(x: 0, y: 0, width: width(), height: statusHeight+toolBarHeight())
        headerBackgroundView.setGradientLayer()
        self.view.addSubview(headerBackgroundView)
        
        //添加标题
        let titleView = UILabel()
        titleView.frame = CGRect(x: 0, y: statusHeight, width: width(), height: toolBarHeight())
        titleView.textColor = UIColor.white
        titleView.font = UIFont.systemFont(ofSize: 21)
        titleView.textAlignment = .center
        titleView.text = title
        self.view.addSubview(titleView)
    }
    
    func setBackTitleBar(_ title:String){
        let headerView = UIView()
        self.view.addSubview(headerView)
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: 0, width: width(), height: statusHeight+toolBarHeight())
        let backImageView = UIImageView()
        self.view.addSubview(backImageView)
        backImageView.frame = CGRect(x: 0, y: statusHeight, width: toolBarHeight(), height: toolBarHeight())
        backImageView.contentMode = .center
        backImageView.image = UIImage(named: "back")?.resize(width: 16, height: 28)
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(tap)
        backImageView.isUserInteractionEnabled = true
        
        let titleView = UILabel()
        self.view.addSubview(titleView)
        titleView.frame = CGRect(x: toolBarHeight(), y: statusHeight, width: width()-toolBarHeight()-toolBarHeight(), height: toolBarHeight())
        titleView.text = title
        titleView.textColor = .black
        titleView.font = UIFont.systemFont(ofSize: 21)
        titleView.textAlignment = .center
        
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: statusHeight+toolBarHeight()-0.5, width: width(), height: 0.5)
        bottomLine.backgroundColor = .lightGray
        headerView.addSubview(bottomLine)
    }
    @objc func back(){
        pop(animated: true)
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
        startColor:UIColor = UIColor(hex: "#5d9cec"),
        //        centerColor:UIColor = UIColor(hex: "#0e65d7"),
        endColor:UIColor = UIColor(hex: "#0e65d7")
        ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.addSublayer(gradientLayer)
    }
}
extension UITabBarItem{
    //设置Tab属性
    func setTabItem(name:String){
        self.image =
            UIImage(named: "\(name)")?.resize()?.withRenderingMode(.alwaysOriginal)
        self.selectedImage =
            UIImage(named: "\(name)_selected")?.resize()?.withRenderingMode(.alwaysOriginal)
        self.title = name
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
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
