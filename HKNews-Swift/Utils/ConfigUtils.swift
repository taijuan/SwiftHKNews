//
//  ConfigUtils.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/8.
//  Copyright © 2019 郑泰捐. All rights reserved.
//


let DNS = "https://api.cdeclips.com/hknews-api"

let ImageDNS = "https://www.chinadailyhk.com"

let EPaperDNS = "https://epaperlib.chinadailyhk.com"

let twitterDNS = "https://twitter.com/chinadailyasia";
let facebookDNS = "https://www.facebook.com/chinadailyhkedition/";

extension String{
    func imageFulPath() -> String{
        return "\(ImageDNS)\(self)"
    }
}
