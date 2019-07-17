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

class WelcomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.of("1")
            .delaySubscription(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: {_ in
                popAndPush(HomeViewController(),animated:false)
            }).disposed(by: disposeBag)
    }
}
