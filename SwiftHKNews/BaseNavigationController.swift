//
//  XPNavigationController.swift
//  PPKit
//
//  Created by xiaopin on 16/8/31.
//  Copyright © 2016年 pinguo. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //1.解决右滑返回失效问题
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
         然后你可以使用下面这句代码来控制是否允许右滑返回，这句代码要加在 viewDidAppear 里面，否则多个页面切换时会出现异常。
         */
        // 2.是否允许右滑返回
        //self.interactivePopGestureRecognizer?.isEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

extension BaseNavigationController:UIGestureRecognizerDelegate{
    ///3.这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            //屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers.first {
                return false
            }
        }
        return true
    }
}


/*
 导航栏各种右滑返回失效的解决方法：
 //https://www.jianshu.com/p/2b2be863bb79
 //https://juejin.im/post/5adeda3051882567336a5dc9
 */

