//
//  LikeViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/18.
//  Copyright © 2019 郑泰捐. All rights reserved.
//
import RxSwift
import Alamofire

class LikeViewModel{
    func like(_ dataId:String)->Observable<String>{
        return Observable<String>.create{observer ->Disposable in
            _ = AF.request("\(DNS)/like?newsId=\(dataId)", method: .get).responseString()
            observer.onNext("")
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
