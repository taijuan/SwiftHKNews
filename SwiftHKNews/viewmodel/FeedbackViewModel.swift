//
//  FeedbackViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/19.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire

class FeedbackViewModel{
    func feedback(content:String,email:String)->Observable<String>{
        return Observable<String>.create{observer ->Disposable in
            _ = AF.request("\(DNS)/addFeedback?content=\(content)&email=\(email)",method: .get).responseString()
            observer.onNext("")
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
