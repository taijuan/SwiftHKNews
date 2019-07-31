//
//  SettingsViewController.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/24.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = lightGray
        self.setBackTitleBar("Settings")
        self.initTableView()
    }
}

extension SettingsViewController:UITableViewDataSource,UITableViewDelegate{
    func initTableView(){
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: statusHeight+toolBarHeight(), width: width(), height: height()-statusHeight-toolBarHeight()-bottom())
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.registerXib(xib: "SettingsTableViewCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SettingsTableViewCell = tableView.getCell(xib: "SettingsTableViewCell", indexPath: indexPath)
        switch indexPath.section {
        case 0:
            cell.nameView.text = "Clear Cache"
            cell.cacheSizeView.isHidden = true
            CacheManager.calculateDiskCashSize{size in
                cell.cacheSizeView.isHidden = false
                cell.cacheSizeView.text = size
            }
            break
        case 1:
            cell.nameView.text = "Version Update"
            cell.cacheSizeView.isHidden = true
            break
        case 2:
            cell.nameView.text = "About Us"
            cell.cacheSizeView.isHidden = true
            break
        default:
            cell.nameView.text = "Accessibility Statement"
            cell.cacheSizeView.isHidden = true
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            CacheManager.cleanCache {
                tableView.reloadData()
            }
            break
        case 1: break
        case 2: break
        default: break
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: width(), height: 10))
    }
}
