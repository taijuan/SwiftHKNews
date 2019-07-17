//
//  EPaper.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/11.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import HandyJSON

class EpaperData:HandyJSON{
    required init() {}
    var newestPubDate:Array<EPaper> = []
}
class EPaper: HandyJSON {
    required init(){}
    var publicationCode:String = ""
    var publicationName:String = ""
    var pubDate:String = ""
    var publicationConfig:PublicationConfig? = nil
    var imageUrl:String = ""
    var htmlUrl:String = ""
}

class PublicationConfig:HandyJSON {
    required init(){}
    var isHide:Int = 0
}


class EPaperImages:HandyJSON{
    required init(){}
    var data:Array<EPaperImage> = []
}

class EPaperImage:HandyJSON{
    required init(){}
    var snapshotBigUrl:String = ""
}

