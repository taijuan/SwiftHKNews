//
//  VideoDetailViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/16.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
import BMPlayer

class VideoDetailViewController: UIViewController {
    private let detail:NewsItem
    private let tableView = UITableView()
    private var data:Array<NewsItem> = []
    private let videoDetailViewModel:VideoDetailViewModel
    private let likeViewModel = LikeViewModel()
    private let favoriteViewModel = FavoriteViewModel()
    private let disposeBag = DisposeBag()
    private let videoViewHeight:CGFloat = width()*9/16
    private lazy var player = BMPlayer()
    private let actionHeight:CGFloat = 44
    private let favorite = UIImageView()
    private let like = UIImageView()
    
    init(data:NewsItem){
        self.detail = data
        self.videoDetailViewModel = VideoDetailViewModel(data: data)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initUITableViewDataSource()
        initActionView()
        initVideoPlayer()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.player.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.player.pause(allowAutoPlay: false)
    }
    
    
    
    func initActionView(){
        let actionView = UIView()
        actionView.frame = CGRect(x: 0, y: statusHeight+videoViewHeight, width: width(), height: actionHeight)
        self.view.addSubview(actionView)
        
        favorite.frame = CGRect(x: 0, y: 0, width: width()/3, height: actionHeight)
        actionView.addSubview(favorite)
        favorite.contentMode = .center
        favorite.image = UIImage(named: "favorite")
        favorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(favoriteAction)))
        favorite.isUserInteractionEnabled = true
        
        like.frame = CGRect(x: width()/3, y: 0, width: width()/3, height: actionHeight)
        actionView.addSubview(like)
        like.contentMode = .center
        like.image = UIImage(named: "like")
        like.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeAction)))
        like.isUserInteractionEnabled = true
        self.favoriteViewModel.isFavorite(self.detail).subscribe(onNext: {data in
            if data{
                self.favorite.image = UIImage(named: "favorite_selected")
            }else{
                self.favorite.image = UIImage(named: "favorite")
            }
        }).disposed(by: disposeBag)
        let share = UIImageView()
        share.frame = CGRect(x: width()*2/3, y: 0, width: width()/3, height: actionHeight)
        actionView.addSubview(share)
        share.contentMode = .center
        share.image = UIImage(named: "share")
        share.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareAction)))
        share.isUserInteractionEnabled = true
        let headerLine = UIView()
        headerLine.frame = CGRect(x: 0, y: 0, width: width(), height: 0.5)
        headerLine.backgroundColor = .lightGray
        actionView.addSubview(headerLine)
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: actionHeight-0.5, width: width(), height: 0.5)
        bottomLine.backgroundColor = .lightGray
        actionView.addSubview(bottomLine)
    }
    @objc func favoriteAction(){
        self.favoriteViewModel.favorite(self.detail).subscribe(onNext: {data in
            self.favorite.image = UIImage(named: "favorite_selected")
        }).disposed(by: disposeBag)
    }
    
    @objc func likeAction(){
        likeViewModel.like(self.detail.dataId).subscribe(onNext: {data in
            self.like.image = UIImage(named: "like_selected")
            logE(any: data)
        }).disposed(by: disposeBag)
    }
    @objc func shareAction(){
        
    }
}
extension VideoDetailViewController:BMPlayerDelegate{
    
    func initVideoPlayer(){
        self.player.frame = CGRect(x: 0, y: statusHeight, width: width(), height: videoViewHeight)
        self.player.delegate = self
        self.view.addSubview(self.player)
        self.player.backBlock = { isFull in
            if isFull == true { return }
            pop(animated: true)
        }
        self.videoDetailViewModel.loadDetail().subscribe(onNext: {data in
            let url = URL(string: data.txyUrl)
            if(url != nil){
                let asset = BMPlayerResource(url: url!,
                                             name: data.title, cover:URL(string: data.bigTitleImage.imageFulPath()))
                self.player.setVideo(resource: asset)
            }
        }).disposed(by: disposeBag)
    }
    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        if isFullscreen == true {
            self.player.frame = CGRect(x: 0, y: 0, width: width(), height: height())
        }else{
            self.player.frame = CGRect(x: 0, y: statusHeight, width: width(), height: videoViewHeight)
        }
    }
}

extension VideoDetailViewController:UITableViewDataSource,UITableViewDelegate{
    func initUITableViewDataSource(){
        self.view.addSubview(tableView)
        self.tableView.frame = CGRect(x: 0, y: statusHeight+videoViewHeight+actionHeight, width: width(), height: height()-statusHeight-videoViewHeight-actionHeight-bottom())
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.registerXib(xib: "VideoTableViewCell")
        self.tableView.registerXib(xib: "VideoHeaderTableViewCell")
        self.videoDetailViewModel.loadLastedData().subscribe(onNext:{data in
            self.data.removeAll()
            self.data += data
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    func reloadData(){
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count+1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if(index == 0){
            let cell:VideoHeaderTableViewCell = tableView.getCell(xib: "VideoHeaderTableViewCell", indexPath: indexPath)
            cell.videoHeaderTitle.text = self.detail.title
            cell.videoHeaderContent.text =  self.detail.description
            cell.videoHeaderSubject.text =  self.detail.subjectName
            return cell
        }else{
            let item = data[index-1]
            let cell:VideoTableViewCell = tableView.getCell(xib: "VideoTableViewCell", indexPath: indexPath)
            cell.videoImage.setImage(imageUrl: item.bigTitleImage.imageFulPath())
            cell.videoTitle.text = item.title
            cell.videoTime.text = item.publishTime
            cell.videoSubject.text = item.subjectName
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index != 0{
            let item = self.data[index-1]
            push(VideoDetailViewController(data: item), animated: true)
        }
    }
}
