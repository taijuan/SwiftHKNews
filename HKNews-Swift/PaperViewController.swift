//
//  PaperViewController.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/5.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift

class PaperViewController: UIViewController {
    private var data:Array<EPaper> = []
    private let disposeBag = DisposeBag()
    private let pagerView = FSPagerView()
    private let h = width()*729/1080
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let epaper_background = UIImageView()
        self.view.addSubview(epaper_background)
        epaper_background.frame = CGRect(x: 0, y: 0, width: width(), height: h)
        epaper_background.image = UIImage(named: "epaper_background")
        epaper_background.contentMode = .scaleAspectFill
        let epaper_title = UIImageView()
        epaper_background.addSubview(epaper_title)
        let w1 = width()*2/3
        let h1 = w1*86/874
        epaper_title.frame = CGRect(x: (width()-w1)/2, y: (h-h1)/2, width: w1, height: h1)
        epaper_title.contentMode = .scaleAspectFill
        epaper_title.image = UIImage(named: "epaper_title")
        initUI()
        let epaperViewModel = EPaperViewModel()
        epaperViewModel.loadData().subscribe(onNext: { data in
            self.data.removeAll()
            self.data += data
            logE(any: self.data)
            self.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
}

extension PaperViewController:FSPagerViewDataSource,FSPagerViewDelegate{
    func initUI(){
        self.view.addSubview(pagerView)
        pagerView.frame = CGRect(x: 0, y: h-48, width: width(), height: height()-h+48-tabBarHeight()-bottom())
        pagerView.register(EPaperFSPagerViewCell.self, forCellWithReuseIdentifier: "EPaperFSPagerViewCell")
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.interitemSpacing = 36
        pagerView.itemSize = CGSize(width: width()*2/3, height: height()-h+48-tabBarHeight()-bottom())
        pagerView.isInfinite = false
    }
    
    func reloadData(){
        self.pagerView.reloadData()
    }
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return data.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:EPaperFSPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "EPaperFSPagerViewCell", at: index) as! EPaperFSPagerViewCell
        cell.setData(data:data[index])
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        logE(any: "xxxxx")
        push(EPaperDetailViewController(data: data[index]), animated: true)
    }
}
