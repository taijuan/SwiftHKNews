//
//  EPaperFSPagerViewCell.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/12.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class EPaperFSPagerViewCell: FSPagerViewCell {
    
    private let  labelH:CGFloat = 48
    private lazy var w:CGFloat = contentView.bounds.width
    private lazy var  h:CGFloat = contentView.bounds.height - labelH
    
    override func layoutSubviews() {
    }
    
    func setData(data:EPaper){
        clearShadow()
        setTitle(title: data.publicationName)
        setLoading()
        let url = URL(string: data.imageUrl)
        let w = contentView.bounds.width
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: w*density, height: h*density), mode: .aspectFit)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.kf.setImage(
            with: url,
            placeholder:UIImage(named: "epaper_loading"),
            options: [
                .processor(processor),
                .transition(.fade(1))
            ]
        ){
            result in
            switch result{
            case .success(let value):
                self.makeConstraints(height: value.image.size.height/density)
            case .failure(let error):
                logE(any:"loading epaper image error :\(error)")
                self.setLoading()
            }
        }
    }
    
    private func setTitle(title:String){
        self.textLabel?.superview?.backgroundColor = .clear
        self.textLabel?.textColor = .black
        self.textLabel?.font = UIFont.systemFont(ofSize: 17)
        self.textLabel?.textAlignment = .center
        self.textLabel?.backgroundColor = .clear
        self.textLabel?.text = title
    }
    private func setLoading(){
        //默认图高度
        let h = w*752/614
        makeConstraints(height: h)
        self.imageView?.image = UIImage(named: "epaper_loading")
    }
    private func makeConstraints (height:CGFloat){
        let frame = self.contentView.bounds
        self.imageView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: height)
        self.textLabel?.superview?.frame = CGRect(x: 0, y: height, width: frame.width, height: labelH)
        self.textLabel?.frame = CGRect(x: 0, y: 0, width: frame.width, height: labelH)
    }
    
    private func clearShadow(){
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.contentView.layer.shadowRadius = 0
        self.contentView.layer.shadowOpacity = 0
        self.contentView.layer.shadowOffset = .zero
    }
}
