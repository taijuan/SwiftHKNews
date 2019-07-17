//
//  State.swift
//  HKNews-Swift
//
//  Created by 郑泰捐 on 2019/7/10.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation
enum State {
    case Init
    case RefreshEmpty
    case RefreshLoadMore
    case RefreshLoadMoreNotData
    case RefreshError(String)
    case LoadMore
    case LoadMoreNotData
    case LoadMoreError(String)
}
