//
//  VideoViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift

class VideoViewController: UIViewController{
    
    private let disposeBag = DisposeBag()
    private var data : Array<NewsItem> = []
    private let videosViewModel = VideosViewModel()
    private lazy var loadingView = LoadingView(view: self.view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //设置UITableView代理
        let table = UITableView()
        table.frame =
            CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-tabBarHeight()-bottom())
        table.dataSource = self
        table.delegate = self
        table.registerXib(xib: "VideoTableViewCell")
        self.view.addSubview(table)
        table.separatorStyle = .none
        //设置UITableView下拉刷新
        table.registerHeader{
            self.videosViewModel.refreshData()
        }
        //自动加载更多
        table.registerFooter{
            self.videosViewModel.loadMoreData()
        }
        
        //设置标题栏
        self.setHeaderTitleBar()
        self.loadingView.showLoading()
        //刷新数据监听
        videosViewModel.refresh.subscribe(onNext: {a in
            self.data.removeAll()
            self.data += a
            logE(any: self.data)
            table.reloadData()
        }).disposed(by: disposeBag)
        
        //加载更多数据监听
        videosViewModel.loadMore.subscribe(onNext: {a in
            self.data += a
            logE(any: self.data)
            table.reloadData()
        }).disposed(by: disposeBag)
        
        //请求状态变化监听
        videosViewModel.state.subscribe(onNext: {a in
            table.mj_header.endRefreshing()
            table.mj_footer.endRefreshing()
            self.loadingView.hideLoading()
        }).disposed(by: disposeBag)
        
        videosViewModel.refreshData()
    }
}


extension VideoViewController: UITableViewDataSource,UITableViewDelegate{
    //cell几种类型
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    //cell注册，UI展示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.data[indexPath.row]
        let cell: VideoTableViewCell = tableView.getCell(xib: "VideoTableViewCell", indexPath: indexPath)
        cell.videoImage.setImage(imageUrl: item.bigTitleImage.imageFulPath())
        cell.videoTime.text = item.publishTime
        cell.videoTitle.text = item.title
        cell.videoSubject.text = item.subjectName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(VideoDetailViewController(data: self.data[indexPath.row]), animated: true)
    }
}
