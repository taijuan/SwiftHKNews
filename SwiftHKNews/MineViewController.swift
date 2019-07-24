//
//  MineViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    let data:Array<IconName> = [favorites,facebook,twitter,feedback,settings]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#f5f5f5")
        setHeaderTitleBar(title: "Me")
        initTableView()
    }
}

extension MineViewController:UITableViewDataSource,UITableViewDelegate{
    
    func initTableView(){
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.registerXib(xib: "MeTableViewCell")
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.section]
        let cell:MeTableViewCell = tableView.getCell(xib: "MeTableViewCell", indexPath: indexPath)
        cell.leftIcon.image = UIImage(named: item.icon)
        cell.name.text = item.name
        cell.rightIcon.image = UIImage(named: "me_next")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.section]
        if(item === favorites){
            push(FavoritesViewController(), animated: true)
        }else if(item === facebook){
            push(WebViewController(title: "Facebook", data: facebookDNS), animated: true)
        }else if(item === twitter){
            push(WebViewController(title: "Twitter", data: twitterDNS), animated: true)
        }else if(item === feedback){
            push(FeedbackViewController(), animated: true)
        }else{
            push(SettingsViewController(), animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let height:CGFloat = (section == 0 || section == 2) ? 10 : 1
        return height
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let height:CGFloat = (section == 0 || section == 2) ? 10 : 1
        return UIView(frame: CGRect(x: 0, y: 0, width: width(), height: height))
    }
}
