//
//  WelcomeViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class WelcomeViewController: BaseViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.just(1)
            .delaySubscription(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: {_ in
                setRootViewController(HomeViewController())
            }).disposed(by: disposeBag)
    }
}
