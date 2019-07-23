//
//  FeedbackViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/19.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire
import Alamofire_Synchronous

class FeedbackViewModel{
    func feedback(content:String,email:String)->Observable<String>{
        return Observable<String>.create{observer ->Disposable in
            let res = Alamofire.request("\(DNS)/addFeedback?content=\(content)&email=\(email)", method: .get).responseString()
            observer.onNext(res.result.value ?? "")
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
