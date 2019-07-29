//
//  SpringBouncesContentView.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/26.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import ESTabBarController_swift

class SpringBouncesContentView: ESTabBarItemContentView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //灰色
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        //红色
        highlightTextColor = UIColor(hex: "#0e65d7")
        highlightIconColor = UIColor(hex: "#0e65d7")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 1
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
