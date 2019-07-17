//
//  BaseRes.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/8.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON
class BaseRes<T:HandyJSON>:HandyJSON{
    var resCode:Int = 0
    var resMsg:String? = nil
    var resObject:T? = nil
    required init() {}
    
}
