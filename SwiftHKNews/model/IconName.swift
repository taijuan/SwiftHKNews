//
//  IconName.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/15.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation

class  IconName {
    let icon:String
    let name:String
    init(icon:String,name:String) {
        self.icon = icon
        self.name = name
    }
}
let favorites = IconName(icon: "me_favorites", name: "My Favorites")
let facebook = IconName(icon: "me_facebook", name: "Facebook")
let twitter = IconName(icon: "me_twitter", name: "Twitter")
let feedback = IconName(icon: "me_feedback", name: "Feedback")
let settings = IconName(icon: "me_settings", name: "Settings")

