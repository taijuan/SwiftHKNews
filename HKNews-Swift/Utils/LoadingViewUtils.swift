//
//  LoadingViewUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

protocol LoadingViewUtils {
    var loadingVIew:UIActivityIndicatorView { get  }
    func showLoading()
    func hideLoading()
}

extension UIView
