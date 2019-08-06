//
//  EPaperViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire
import Alamofire_Synchronous
class EPaperViewModel{
    private let epaperData = BehaviorSubject<Array<EPaper>>(value: [])
    let refresh:Observable<Array<EPaper>>
    init(){
        refresh = epaperData.asObserver().filter({a in return !a.isEmpty})
    }
    
    func loadData()-> Observable<Array<EPaper>>{
        return Observable<Array<EPaper>>.create { observer -> Disposable in
            let response = Alamofire.request("\(EPaperDNS)/pubs/config.json", method: .get).responseString()

            let a = EpaperData.deserialize(from: response.result.value)
            let arr = (a?.newestPubDate ?? []).filter({a in return a.publicationConfig?.isHide == 0})
            
            for item in arr {
                let url = "\(EPaperDNS)/pubs/\(item.publicationCode)/\(self.strFormat(date: item.pubDate))/issue.json"
                item.htmlUrl = "\(EPaperDNS)/mobile/index.html?pubCode=\(item.publicationCode)&pubDate=\(item.pubDate)"
                let response = Alamofire.request(url, method: .get).responseString()
                logE(any: url)
                let a = EPaperImages.deserialize(from: response.result.value)
                item.imageUrl = "\(EPaperDNS)/pubs\(a?.data[0].snapshotBigUrl ?? "")"
            }
            observer.onNext(arr)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func strFormat(date: String)-> String{
        var newDate: String = ""
        if (date.contains("-")) {
            newDate = date.replacingOccurrences(of: "-", with: "/")
        }
        return newDate
    }
}
