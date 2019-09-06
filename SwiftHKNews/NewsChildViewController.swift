//
//  NewsChildViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/9.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
import FSPagerView
import JXSegmentedView

class NewsChildViewController: BaseViewController {
    private var code :String = ""
    private var pagerData:Array<NewsItem> = []
    private var data:Array<NewsItem> = []
    private let disposeBag = DisposeBag()
    private lazy var pageView = FSPagerView()
    private lazy var pageControl = FSPageControl()
    private lazy var table = UITableView()
    private lazy var loadingView = LoadingView(view: self.view)
    private lazy var newsViewModel:NewsViewModel = NewsViewModel(code: self.code)
    init(code:String){
        super.init(nibName: nil, bundle: nil)
        self.code = code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加UITableView
        self.view.frame = CGRect(x: 0, y: 0, width: width(), height: height()-statusHeight-toolBarHeight()-pageTabBarHeight()-tabBarHeight()-bottom())
        table.frame = self.view.bounds
        logE(any: "####################################")
        logE(any: self.view.bounds)
        logE(any: self.table.frame)
        logE(any: self.table.center)
        logE(any: "####################################")
        table.dataSource = self
        table.delegate = self
        table.registerXib(xib: "NewsTableViewCell")
        self.view.addSubview(table)
        table.separatorStyle = .none
        initHeaderPager()
        
        table.registerHeader {
            self.newsViewModel.refreshData()
            logE(any: "refreshData")
        }
        if self.code != "home"{
            table.registerFooter {
                self.newsViewModel.loadMoreData()
                logE(any: "loadMoreData")
            }
        }
        self.loadingView.showLoading()
        newsViewModel.pager.subscribe(onNext: {data in
            self.pagerData.removeAll()
            self.pagerData += data
            self.reloadData()
        }).disposed(by: disposeBag)
        newsViewModel.refresh.subscribe(onNext: {data in
            self.data.removeAll()
            self.data += data
            logE(any: data)
            self.table.reloadData()
        }).disposed(by: disposeBag)
        
        newsViewModel.loadMore.subscribe(onNext: {data in
            self.data += data
            logE(any: data)
            self.table.reloadData()
        }).disposed(by: disposeBag)
        newsViewModel.state.subscribe(onNext: {state in
            self.table.mj_header.endRefreshing()
            if self.code != "home"{
                self.table.mj_footer.endRefreshing()
            }
            self.loadingView.hideLoading()
        }).disposed(by: disposeBag)
        newsViewModel.refreshData()
    }
}

extension NewsChildViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsTableViewCell = tableView.getCell(xib: "NewsTableViewCell", indexPath: indexPath)
        let item = self.data[indexPath.row]
        cell.newsImage.setImage(imageUrl: item.bigTitleImage.imageFulPath())
        cell.newsTitle.text = item.title
        cell.newsDescription.text = item.description
        cell.newsTime.text = item.publishTime
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(NewsDetailViewController(data: self.data[indexPath.row]), animated: true)
    }
}
extension NewsChildViewController:FSPagerViewDataSource,FSPagerViewDelegate{
    
    func initHeaderPager(){
        let h = width()*9/16
        let header = UIView()
        header.addSubview(self.pageView)
        header.addSubview(self.pageControl)
        self.table.tableHeaderView=header
        header.frame = CGRect(x: 0, y: 0, width: width(), height: width()*9/16)
        self.pageView.frame = header.bounds
        self.pageView.isInfinite = true
        self.pageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        self.pageView.dataSource = self
        self.pageView.delegate = self
        
        self.pageControl.frame = CGRect(x: 0, y: h-16, width: width()-16, height: 8)
        self.pageControl.contentHorizontalAlignment = .right
        self.pageControl.setFillColor(.lightGray, for: .normal)
        self.pageControl.setFillColor(.blue, for: .selected)
        self.pageControl.itemSpacing = 8
        self.pageControl.interitemSpacing = 8
    }
    
    func reloadData(){
        self.pageControl.numberOfPages = self.pagerData.count
        self.pageView.reloadData()
    }
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return pagerData.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:FSPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        let item = self.pagerData[index]
        cell.imageView?.setImage(imageUrl: item.bigTitleImage.imageFulPath())
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        push(NewsDetailViewController(data: self.pagerData[index]), animated: true)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

extension NewsChildViewController : JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
