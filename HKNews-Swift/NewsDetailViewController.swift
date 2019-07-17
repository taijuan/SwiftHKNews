//
//  WebViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit
import RxGesture

class WebViewController: UIViewController {

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
        webView.snp.makeConstraints{ make in
            make.height.equalTo(height()-top()-tabBarHeight()-bottom())
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(top())
        }
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.snp.makeConstraints{make in
            make.height.equalTo(tabBarHeight()+bottom())
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        let backImageView = UIImageView()
        bottomView.addSubview(backImageView)
        backImageView.snp.makeConstraints{make in
            make.width.height.equalTo(48)
        }
        backImageView.contentMode = .center
        backImageView.image = UIImage(named: "back")?.resize(width: 16, height: 28)
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(tap)
        backImageView.isUserInteractionEnabled = true
        webView.load(URLRequest.init(url: URL(string: "\(ImageDNS)\(self.data.murl)")!))
    }
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}
