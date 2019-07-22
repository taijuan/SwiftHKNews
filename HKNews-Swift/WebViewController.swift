//
//  WebViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/15.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    private let data:String
    private let name:String
    private let webView = WKWebView()
    private lazy var loadingView = LoadingView(view: self.view)
    init(title:String,data:String){
        self.name = title
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.initWKNavigationDelegate()
        self.setBackTitleBar(name)
    }
}

extension WebViewController:WKNavigationDelegate{
    func initWKNavigationDelegate(){
        self.webView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
        self.webView.load(URLRequest(url: URL(string: data)!))
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.loadingView.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.hideLoading()
    }
}
