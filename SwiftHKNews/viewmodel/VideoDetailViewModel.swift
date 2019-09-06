//
//  VideoDetailViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/16.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire

class VideoDetailViewModel{
    let data:NewsItem
    init(data:NewsItem) {
        self.data = data
    }
    func loadDetail()->Observable<NewsItem>{
        return Observable<NewsItem>.create{observer ->Disposable in
            let url = "\(DNS)/selecNewsDetail?dataId=\(self.data.dataId)"
            logE(any: url)
            let response = AF.request(url,method: .get).responseString()
            switch(response.result){
            case .failure(_):
                observer.onNext(self.data)
            case .success(let success):
                let a = BaseRes<NewsItem>.deserialize(from: success)
                observer.onNext(a?.resObject ?? self.data)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func loadLastedData()->Observable<Array<NewsItem>>{
        return Observable<Array<NewsItem>>.create{observer -> Disposable in
            let url = "\(DNS)/selectNewsList?subjectCode=\(self.data.subjectCode)&currentPage=1&dataType=3"
            let response = AF.request(url, method: .get).responseString()
            switch(response.result){
            case .failure(_):
                observer.onNext([])
            case .success(let success):
                let a = BaseRes<DataList<NewsItem>>.deserialize(from: success)
                var arr = a?.resObject?.dateList ?? []
                arr = arr.filter{a in return a.dataId != self.data.dataId}
                observer.onNext(arr)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

