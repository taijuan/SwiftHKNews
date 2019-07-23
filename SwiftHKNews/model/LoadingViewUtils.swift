//
//  LoadingViewUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

protocol LoadingViewUtils {
    func showLoading()
    func hideLoading()
}

class LoadingView :LoadingViewUtils{
    private let loadingVIew: UIActivityIndicatorView
    private let view:UIView
    required init(view:UIView){
        loadingVIew = UIActivityIndicatorView(style: .whiteLarge)
        loadingVIew.center = view.center
        loadingVIew.color = .red
        self.view = view
        view.addSubview(loadingVIew)
        logE(any: "initLoadingView")
    }
    
    func showLoading() {
        loadingVIew.center = view.center
        loadingVIew.startAnimating()
        logE(any: "showLoadingView")
    }
    
    func hideLoading() {
        loadingVIew.stopAnimating()
        logE(any: "hideLoadingView")
    }
    
    
}
