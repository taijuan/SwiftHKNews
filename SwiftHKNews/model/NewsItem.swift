//
//  NewsItem.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON
import RealmSwift
class NewsItem:HandyJSON{
    required init(){}
    var id:String = ""
    var dataId:String = ""
    var title: String = ""
    var bigTitleImage: String = ""
    var dataType:Int = 1
    var subjectName:String = ""
    var subjectCode:String = ""
    var publishTime:String = ""
    var jsonUrl:String = ""
    var murl:String = ""
    var description:String = ""
    var txyUrl:String = ""
}

extension NewsItem {
    func to()->Favorite{
        let favirite = Favorite()
        favirite.id = self.id
        favirite.dataId = self.dataId
        favirite.title = self.title
        favirite.bigTitleImage = self.bigTitleImage
        favirite.dataType = self.dataType
        favirite.subjectName = self.subjectName
        favirite.subjectCode = self.subjectCode
        favirite.publishTime = self.publishTime
        favirite.jsonUrl = self.jsonUrl
        favirite.murl = self.murl
        favirite.des = self.description
        favirite.txyUrl = self.txyUrl
        return favirite
    }
}
