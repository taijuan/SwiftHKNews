//
//  LoadingViewUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift

protocol LoadingViewUtils {
    func showLoading()
    func hideLoading()
}

class LoadingView :LoadingViewUtils{
    private let loadingVIew: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let view:UIView
    required init(view:UIView){
        self.view = view
        loadingVIew.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingVIew.color = blue
        loadingVIew.backgroundColor = halfTransparent
        loadingVIew.layer.cornerRadius = 8
        self.view.addSubview(loadingVIew)
        logE(any: "initLoadingView")
    }
    
    func showLoading() {
        let bounds = view.bounds
        loadingVIew.center = CGPoint(x: bounds.midX, y: bounds.midY)
        loadingVIew.startAnimating()
        logE(any: "showLoadingView")
    }
    
    func hideLoading() {
        if(loadingVIew.isAnimating){
            loadingVIew.stopAnimating()
        }
        logE(any: "hideLoadingView")
    }
}



class LoadingViewController:UIViewController,LoadingViewUtils{
    private let disposeBag = DisposeBag()
    private lazy var loadingView = LoadingView(view: self.view)
//    override func viewDidLoad() {
//        self.modalPresentationStyle = .custom
//    }
    static func createLoadingDialog()->LoadingViewController{
        let dialog =  LoadingViewController()
        dialog.view.backgroundColor = halfTransparent
        dialog.modalPresentationStyle = .custom
        return dialog
    }
    func showLoading() {
        getRootViewController()?.present(self, animated: false, completion: nil)
        loadingView.showLoading()
    }
    
    func hideLoading() {
        loadingView.hideLoading()
        getRootViewController()?.dismiss(animated: false, completion: nil)
    }
    
    func delayHideLoading(){
        Observable.just(1).delay(DispatchTimeInterval.seconds(10), scheduler: MainScheduler.instance).subscribe(onNext: nil, onError: nil, onCompleted: {
            self.hideLoading()
        }).disposed(by: disposeBag)
    }
}
