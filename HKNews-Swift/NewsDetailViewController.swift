//
//  WebViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    private let data:NewsItem
    init(data:NewsItem){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let webView = WKWebView()
        self.view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: statusHeight, width: width(), height: height()-statusHeight-tabBarHeight()-bottom())
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.frame = CGRect(x: 0, y: height()-tabBarHeight()-bottom(), width: width(), height: tabBarHeight()+bottom())
        
        let backImageView = UIImageView()
        bottomView.addSubview(backImageView)
        backImageView.frame = CGRect(x: 0, y: 0, width: tabBarHeight(), height: tabBarHeight())
        backImageView.contentMode = .center
        backImageView.image = UIImage(named: "back")?.resize(width: 16, height: 28)
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(tap)
        backImageView.isUserInteractionEnabled = true
        webView.load(URLRequest.init(url: URL(string: "\(ImageDNS)\(self.data.murl)")!))
    }
    @objc func back(){
        pop(animated: true)
    }
}
