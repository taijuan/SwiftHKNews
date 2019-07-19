//
//  WebViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class NewsDetailViewController: UIViewController {
    
    private let data:NewsItem
    private let disposeBag = DisposeBag()
    private let likeViewModel = LikeViewModel()
    private let favoriteViewModel = FavoriteViewModel()
    private let favorite = UIImageView()
    private let like = UIImageView()
    
    init(data:NewsItem){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let webView = WKWebView()
        self.view.addSubview(webView)
        webView.frame = CGRect(x: 0, y: statusHeight, width: width(), height: height()-statusHeight-tabBarHeight()-bottom())
        webView.load(URLRequest.init(url: URL(string: "\(ImageDNS)\(self.data.murl)")!))
        initBottomView()
    }
    
    func initBottomView(){
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.frame = CGRect(x: 0, y: height()-tabBarHeight()-bottom(), width: width(), height: tabBarHeight()+bottom())
        
        let backImageView = UIImageView()
        bottomView.addSubview(backImageView)
        backImageView.frame = CGRect(x: 0, y: 0, width: tabBarHeight(), height: tabBarHeight())
        backImageView.contentMode = .center
        backImageView.image = UIImage(named: "back")?.resize(width: 16, height: 28)
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(tap)
        backImageView.isUserInteractionEnabled = true
        favorite.frame = CGRect(x: width()-3*tabBarHeight(), y: 0, width: tabBarHeight(), height: tabBarHeight())
        bottomView.addSubview(favorite)
        favorite.contentMode = .center
        favorite.image = UIImage(named: "favorite")?.resize(width: 24, height: 24)
        favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteAction)))
        favorite.isUserInteractionEnabled = true
        
        like.frame = CGRect(x: width()-2*tabBarHeight(), y: 0, width: tabBarHeight(), height: tabBarHeight())
        bottomView.addSubview(like)
        like.contentMode = .center
        like.image = UIImage(named: "like")?.resize(width: 24, height: 24)
        like.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeAction)))
        like.isUserInteractionEnabled = true
        self.favoriteViewModel.isFavorite(self.data).subscribe(onNext: {data in
            if data{
                self.favorite.image = UIImage(named: "favorite_selected")?.resize(width: 24, height: 24)
            }else{
                self.favorite.image = UIImage(named: "favorite")?.resize(width: 24, height: 24)
            }
        }).disposed(by: disposeBag)
        let share = UIImageView()
        share.frame = CGRect(x: width()-tabBarHeight(), y: 0, width: tabBarHeight(), height: tabBarHeight())
        bottomView.addSubview(share)
        share.contentMode = .center
        share.image = UIImage(named: "share")?.resize(width: 24, height: 24)
        share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareAction)))
        share.isUserInteractionEnabled = true
        
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: width(), height: 0.5)
        line.backgroundColor = .lightGray
        bottomView.addSubview(line)
        
    }
    @objc func favoriteAction(){
        self.favoriteViewModel.favorite(self.data).subscribe(onNext: {data in
            self.favorite.image = UIImage(named: "favorite_selected")?.resize(width: 24, height: 24)
        }).disposed(by: disposeBag)
    }
    
    @objc func likeAction(){
        likeViewModel.like(self.data.dataId).subscribe(onNext: {data in
            self.like.image = UIImage(named: "like_selected")?.resize(width: 24, height: 24)
            logE(any: data)
        }).disposed(by: disposeBag)
    }
    @objc func shareAction(){
        
    }
}
