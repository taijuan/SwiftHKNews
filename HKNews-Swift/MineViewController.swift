//
//  MineViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    let tableView = UITableView()
    let data:Array<IconName> = [favorites,facebook,twitter,feedback,settings]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setHeaderTitleBar(title: "Me")
        self.view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
        tableView.separatorStyle = .none
        initUITableViewDataSource()
        initUITableViewDelegate()
    }
}

extension MineViewController:UITableViewDataSource{
    
    func initUITableViewDataSource(){
        self.tableView.dataSource = self
        self.tableView.registerXib(xib: "MeTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell:MeTableViewCell = tableView.getCell(xib: "MeTableViewCell", indexPath: indexPath)
        cell.leftIcon.image = UIImage(named: item.icon)?.resize()
        cell.name.text = item.name
        cell.rightIcon.image = UIImage(named: "me_next")?.resize(width: 16, height: 16)
        return cell
    }
}

extension MineViewController:UITableViewDelegate{
    func initUITableViewDelegate(){
        self.tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        if(item === favorites){
            push(FavoritesViewController(), animated: true)
        }else if(item === facebook){
            push(WebViewController(title: "Facebook", data: facebookDNS), animated: true)
        }else if(item === twitter){
            push(WebViewController(title: "Twitter", data: twitterDNS), animated: true)
        }else if(item === feedback){
            push(FeedbackViewController(), animated: true)
        }else{
            
        }
    }
}
