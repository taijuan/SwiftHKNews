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
    let detail:NewsItem
    let tableView = UITableView()
    private var data:Array<NewsItem> = []
    let videoDetailViewModel:VideoDetailViewModel
    let disposeBag = DisposeBag()
    let videoViewHeight = width()*9/16
    private lazy var player = BMPlayer()
    
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
        self.view.addSubview(tableView)
        initVideoPlayer()
        tableView.frame = CGRect(x: 0, y: statusHeight+videoViewHeight, width: width(), height: height()-statusHeight-videoViewHeight-bottom())
        initUITableViewDataSource()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.player.pause(allowAutoPlay: true)
    }
}
extension VideoDetailViewController:BMPlayerDelegate{
    
    func initVideoPlayer(){
        logE(any: "top --> \(statusHeight)")
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
            popAndPush(VideoDetailViewController(data: item), animated: true)
        }
    }
}
