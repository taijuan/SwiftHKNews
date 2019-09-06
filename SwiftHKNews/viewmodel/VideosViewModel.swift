//
//  VideosViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/8.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RxSwift
import Alamofire

class VideosViewModel {
    private var curPage = 0
    private let refreshBV = BehaviorSubject<Array<NewsItem>>(value: [])
    let refresh:Observable<Array<NewsItem>>
    private let loadMoreBV = BehaviorSubject<Array<NewsItem>>(value: [])
    let loadMore:Observable<Array<NewsItem>>
    private let stateBV = BehaviorSubject<State>(value: .Init)
    let state:Observable<State>
    init() {
        refresh = refreshBV.asObserver().filter({a in return !a.isEmpty })
        loadMore = loadMoreBV.asObserver().filter({a in return !a.isEmpty })
        state = stateBV.asObserver().filter{a in
            switch(a){
            case .Init: return false
            default: return true
            }
        }
    }
    
    func refreshData(){
        AF.request("\(DNS)/selectNewsList?currentPage=1&dataType=3", method: .get)
            .responseString(completionHandler: { response in
                switch(response.result){
                case .failure(let failure):
                    self.stateBV.onNext(.RefreshError("\(failure)"))
                case .success(let success):
                    let a = BaseRes<DataList<NewsItem>>.deserialize(from: success)
                    if(a?.resCode != 200){
                        self.stateBV.onNext(.RefreshError(a?.resMsg ?? ""))
                        return
                    }
                    let b = a?.resObject?.dateList ?? []
                    if(a?.resObject?.totalPage == a?.resObject?.totalPage){
                        if b.isEmpty {
                            self.stateBV.onNext(.RefreshEmpty)
                        }else{
                            self.stateBV.onNext(.RefreshLoadMoreNotData)
                        }
                    }else{
                        self.stateBV.onNext(.RefreshLoadMore)
                    }
                    self.refreshBV.onNext(b)
                    self.curPage = 1
                }
            })
    }
    
    func loadMoreData(){
        AF.request("\(DNS)/selectNewsList?currentPage=\(self.curPage+1)&dataType=3", method: .get)
        .responseString(completionHandler: {response in
            switch(response.result){
            case .failure(let failure):
                self.stateBV.onNext(.LoadMoreError("\(failure)"))
            case .success(let success):
                let a = BaseRes<DataList<NewsItem>>.deserialize(from: success)
                if(a?.resCode != 200){
                    self.stateBV.onNext(.LoadMoreError(a?.resMsg ?? ""))
                    return
                }
                if(a?.resObject?.totalPage == a?.resObject?.totalPage){
                    self.stateBV.onNext(.LoadMoreNotData)
                }else{
                    self.stateBV.onNext(.LoadMore)
                }
                self.loadMoreBV.onNext(a?.resObject?.dateList ?? [])
                self.curPage = self.curPage+1
            }
        })
    }
}
