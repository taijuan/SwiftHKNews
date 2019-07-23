//
//  Favorite.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/18.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import RealmSwift

class Favorite:Object{
    @objc dynamic var id:String = ""
    @objc dynamic var dataId:String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var bigTitleImage: String = ""
    @objc dynamic var dataType:Int = 1
    @objc dynamic var subjectName:String = ""
    @objc dynamic var subjectCode:String = ""
    @objc dynamic var publishTime:String = ""
    @objc dynamic var jsonUrl:String = ""
    @objc dynamic var murl:String = ""
    @objc dynamic var des:String = ""
    @objc dynamic var txyUrl:String = ""
    
    override static func primaryKey() -> String? {
        return "dataId"
    }
}
extension Favorite {
    func to()->NewsItem{
        let news = NewsItem()
        news.id = self.id
        news.dataId = self.dataId
        news.title = self.title
        news.bigTitleImage = self.bigTitleImage
        news.dataType = self.dataType
        news.subjectName = self.subjectName
        news.subjectCode = self.subjectCode
        news.publishTime = self.publishTime
        news.jsonUrl = self.jsonUrl
        news.murl = self.murl
        news.description = self.des
        news.txyUrl = self.txyUrl
        return news
    }
}
