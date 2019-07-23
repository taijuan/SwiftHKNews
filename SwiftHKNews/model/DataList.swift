//
//  DataList.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/8.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON

class DataList<T:HandyJSON>: HandyJSON {
    required init(){}
    var dateList:Array<T> = []
    var top_focus:Array<T> = []
    var allLists:Array<T> = []
    var totalPage:Int = 0
    var currentPage:Int = 0
}
