//
//  EPaperDetailViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/15.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class EPaperDetailViewController: UIViewController {
    private let data:EPaper
    private let webView = WKWebView(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
    private lazy var loadingView  = LoadingView(view: self.view)
    init(data:EPaper){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initWKNavigationDelegate()
        self.setBackTitleBar("EPaper")
    }
}


extension EPaperDetailViewController:WKNavigationDelegate{
    func initWKNavigationDelegate(){
        self.view.addSubview(self.webView)
        self.webView.load(URLRequest.init(url: URL(string: self.data.htmlUrl)!))
        self.webView.navigationDelegate = self
        self.loadingView.showLoading()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString ?? ""
        if url.contains(".pdf"){
            push(WebViewController(title: "EPaper", data: url), animated: true)
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingView.hideLoading()
    }
}
