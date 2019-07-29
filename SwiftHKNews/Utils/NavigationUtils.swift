//
//  NavigationUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/17.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

func currentViewController()->UIViewController?{
    return UIViewController.currentViewController()
}

func setRootViewController(_ viewController:UIViewController){
    let rootViewController = UINavigationController(rootViewController: viewController)
    rootViewController.navigationBar.isHidden = true
    let appDelegate:AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    appDelegate?.window?.rootViewController = rootViewController
}
func pop(animated: Bool){
    currentViewController()?.navigationController?.popViewController(animated: animated)
}

func popRootController(){
    currentViewController()?.navigationController?.popToRootViewController(animated: true)
}
//func popAndPush(_ viewController:UIViewController,animated:Bool){
//    currentViewController()?.navigationController?.popViewController(animated: true)
//    currentViewController()?.navigationController?.pushViewController(viewController, animated: animated)
//}

func push(_ viewController:UIViewController,animated:Bool){
    currentViewController()?.navigationController?.pushViewController(viewController, animated: animated)
}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
