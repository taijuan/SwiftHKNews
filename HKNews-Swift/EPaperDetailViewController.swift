//
//  EPaperDetailViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/15.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit

class EPaperDetailViewController: UIViewController {
    private let data:EPaper
    private let webView = WKWebView()
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
        
        self.view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
        webView.load(URLRequest.init(url: URL(string: self.data.htmlUrl)!))
        initWKUIDelegate()
        initWKNavigationDelegate()
        
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
        logE(any: "title: \(titleView.bounds.width)")
        titleView.text = "EPaper"
        titleView.textColor = .black
        titleView.font = UIFont.systemFont(ofSize: 21)
        titleView.textAlignment = .center
    }
    
    @objc func back(){
        pop(animated: true)
    }
}
extension EPaperDetailViewController:WKUIDelegate{
    func initWKUIDelegate(){
        self.webView.uiDelegate = self
    }
}

extension EPaperDetailViewController:WKNavigationDelegate{
    func initWKNavigationDelegate(){
        self.webView.navigationDelegate = self
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url?.absoluteString ?? ""
        logE(any: "url: \(url)")
        decisionHandler(.allow)
    }
}
