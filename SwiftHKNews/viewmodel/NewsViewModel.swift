//
//  NewsViewModel.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//


import RxSwift
import Alamofire
class NewsViewModel {
    private var code = "home"
    private var curPage = 0
    private let refreshBV = BehaviorSubject<Array<NewsItem>>(value: [])
    let refresh: Observable<Array<NewsItem>>
    private let pagerBV = BehaviorSubject<Array<NewsItem>>(value: [])
    let pager: Observable<Array<NewsItem>>
    private let loadMoreBV = BehaviorSubject<Array<NewsItem>>(value: [])
    let loadMore: Observable<Array<NewsItem>>
    private let stateBV = BehaviorSubject<State>(value: .Init)
    let state: Observable<State>

    init(code: String) {
        self.code = code
        refresh = refreshBV.asObserver().filter({ a in return !a.isEmpty })
        pager = pagerBV.asObserver().filter({ a in return !a.isEmpty })
        loadMore = loadMoreBV.asObserver().filter({ a in return !a.isEmpty })
        state = stateBV.asObserver().filter { a in
            switch (a) {
            case .Init: return false
            default: return true
            }
        }
    }

    func refreshData() {
        logE(any: getUrl())
        AF.request(getUrl(),method: .get).responseString { (response) in
            switch(response.result){
            case .failure(let failure):
                self.stateBV.onNext(.RefreshError("\(failure)"))
            case .success(let success):
                let a = BaseRes<DataList<NewsItem>>.deserialize(from: success)
                if (a?.resCode != 200) {
                    self.stateBV.onNext(.RefreshError(a?.resMsg ?? ""))
                    return
                }
                
                if self.code == "home" {
                    self.stateBV.onNext(.RefreshLoadMoreNotData)
                    self.refreshBV.onNext(a?.resObject?.allLists ?? [])
                    self.pagerBV.onNext(a?.resObject?.top_focus ?? [])
                } else {
                    let b = a?.resObject?.dateList ?? []
                    if (a?.resObject?.totalPage == a?.resObject?.totalPage) {
                        if b.isEmpty {
                            self.stateBV.onNext(.RefreshEmpty)
                        } else {
                            self.stateBV.onNext(.RefreshLoadMoreNotData)
                        }
                    } else {
                        self.stateBV.onNext(.RefreshLoadMore)
                    }
                    self.pagerBV.onNext(self.getArrayTop5(data: b))
                    self.refreshBV.onNext(self.getLastArray(data: b))
                    self.curPage = 1
                }
            }
        }
    }

    //去数组前5的集合
    func getArrayTop5(data: Array<NewsItem>) -> Array<NewsItem> {
        var c: Array<NewsItem> = []
        if data.count <= 5 {
            c += data
        } else {
            c += data[0...4]
        }
        return c
    }

    func getLastArray(data: Array<NewsItem>) -> Array<NewsItem> {
        var c: Array<NewsItem> = []
        if data.count > 5 {
            c += data[5...]
        }
        return c
    }

    func loadMoreData() {
        AF.request(getUrl(curPage: self.curPage + 1), method: .get).responseString(completionHandler: {response in
            switch(response.result){
            case .failure(let failure):
                self.stateBV.onNext(.LoadMoreError("\(failure)"))
            case .success(let success):
                let a = BaseRes<DataList<NewsItem>>.deserialize(from: success)
                if (a?.resCode != 200) {
                    self.stateBV.onNext(.LoadMoreError(a?.resMsg ?? ""))
                    return
                }
                if (a?.resObject?.totalPage == a?.resObject?.totalPage) {
                    self.stateBV.onNext(.LoadMoreNotData)
                } else {
                    self.stateBV.onNext(.LoadMore)
                }
                self.loadMoreBV.onNext(a?.resObject?.dateList ?? [])
                self.curPage += 1
            }
        })
    }


    func getUrl(curPage: Int = 1) -> String {
        if self.code == "home" {
            return "\(DNS)/homeDataNewsList"
        } else {
            return "\(DNS)/selectNewsList?subjectCode=\(self.code)&currentPage=\(curPage)&dataType=1"
        }
    }
}
