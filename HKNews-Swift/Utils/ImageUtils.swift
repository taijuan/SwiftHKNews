//
//  ImageUtisl.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/4.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit
import Kingfisher


extension UIImageView {
    func setImage(imageUrl:String){
        let url = URL(string: imageUrl)
//        let w = self.bounds.width
//        let h = self.bounds.height
//        logE(any:"width:\(w) , height:\(h)")
//        let processor = ResizingImageProcessor(referenceSize: CGSize(width: w, height: h), mode: .aspectFit)
        self.kf.setImage(
            with: url,
            placeholder:UIImage(named: "pic_loading"),
            options: [
//                .processor(processor),
                .transition(.fade(1))
            ]
        )
    }
}

extension UIImage {
    func resize(width:CGFloat = 32,height:CGFloat = 32) -> UIImage? {
        let w = self.size.width
        let h = self.size.height
        let dw = w/width
        let dh = h/height
        logE(any: "w: \(w), h: \(h)")
        logE(any: "dw: \(dw), dh: \(dh)")
        if(dw<=1&&dh<=1){
            return self
        }
        let scale = CGFloat.maximum(dw, dh)
        let sw = w/scale
        let sh = h/scale
        logE(any: "sw: \(sw), sh: \(sh)")
        UIGraphicsBeginImageContext(CGSize(width: sw, height: sh))
        draw(in: CGRect(x: 0, y: 0, width: sw, height: sh))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
