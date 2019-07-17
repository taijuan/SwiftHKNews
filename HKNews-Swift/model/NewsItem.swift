//
//  NewsItem.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON

class NewsItem:HandyJSON{
    required init(){}
    var id:String = ""
    var dataId:String = ""
    var title: String = ""
    var bigTitleImage: String = ""
    var dataType:Int = 3
    var subjectName:String = ""
    var subjectCode:String = ""
    var publishTime:String = ""
    var jsonUrl:String = ""
    var murl:String = ""
    var description:String = ""
    var txyUrl:String = ""
}
