//
//  FavoritesViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/18.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import RxSwift
class FavoritesViewController: UIViewController {
    private let tableView = UITableView()
    private var data:Array<NewsItem> = []
    private var disposeBag = DisposeBag()
    private let favoriteViewModel = FavoriteViewModel();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.setBackTitleBar("Favorites")
    }
}

extension FavoritesViewController:UITableViewDataSource,UITableViewDelegate{
    
    func initTableView(){
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight())
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerXib(xib: "NewsTableViewCell")
        self.tableView.registerXib(xib: "VideoTableViewCell")
        self.favoriteViewModel.getFavorites().subscribe(onNext: {data in
            self.data = data
            self.reload()
        }).disposed(by: disposeBag)
    }
    
    func reload(){
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.data[indexPath.row]
        if item.dataType == 3{
            let cell:VideoTableViewCell = tableView.getCell(xib: "VideoTableViewCell", indexPath: indexPath)
            cell.videoImage.setImage(imageUrl: item.bigTitleImage.imageFulPath())
            cell.videoTime.text = item.publishTime
            cell.videoTitle.text = item.title
            cell.videoSubject.text = item.subjectName
            return cell
        }else{
            let cell:NewsTableViewCell = tableView.getCell(xib: "NewsTableViewCell", indexPath: indexPath)
            cell.newsImage.setImage(imageUrl: item.bigTitleImage.imageFulPath())
            cell.newsTitle.text = item.title
            cell.newsDescription.text = item.description
            cell.newsTime.text = item.publishTime
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            logE(any: "xxxxxxx delete")
            let item = data[indexPath.row]
            self.data.remove(at: indexPath.row)
            self.favoriteViewModel.deleteFavorite(item).subscribe(onNext: {data in
                tableView.deleteRows(at: [indexPath], with: .fade)
            }).disposed(by: disposeBag)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.data[indexPath.row]
        if item.dataType == 3{
            push(VideoDetailViewController(data:item),animated: true)
        }else{
            push(NewsDetailViewController(data:item),animated: true)
        }
    }
}
