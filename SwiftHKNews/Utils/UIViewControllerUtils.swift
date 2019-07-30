//
//  UIViewControllerUtils.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/30.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

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
        backImageView.image = UIImage(named: "back")
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
