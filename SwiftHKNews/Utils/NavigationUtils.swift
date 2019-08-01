//
//  NavigationUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/17.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import UIKit

func getWindow()->UIWindow?{
    let appDelegate:AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    return appDelegate?.window
}
func getRootViewController()->UIViewController?{
    return getWindow()?.rootViewController
}
func setRootViewController(_ viewController:UIViewController){
    let rootViewController = UINavigationController(rootViewController: viewController)
    //隐藏标题栏方式
    //rootViewController.isNavigationBarHidden = true
    //该方式隐藏标题栏，会导致UINavigation侧滑返回失效
    rootViewController.navigationBar.isHidden = true
    getWindow()?.rootViewController = rootViewController
}
func pop(animated: Bool){
    let viewController = getWindow()?.rootViewController
    if viewController is UINavigationController{
        (viewController as! UINavigationController).popViewController(animated: animated)
    }else{
        viewController?.dismiss(animated: animated, completion: nil)
    }
    
}

func popRootController(){
    let viewController = getWindow()?.rootViewController
    if viewController is UINavigationController{
        (viewController as! UINavigationController).popViewController(animated: true)
    }else{
        viewController?.dismiss(animated: true, completion: nil)
    }
}

func push(_ controller:UIViewController,animated:Bool){
    let viewController = getWindow()?.rootViewController
    if viewController is UINavigationController{
        (viewController as! UINavigationController).pushViewController(controller, animated: animated)
    }else{
        viewController?.present(controller,animated: true, completion: nil)
    }
}
