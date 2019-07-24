//
//  CacheManager.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/7/24.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Kingfisher

class CacheManager{
    class func calculateDiskCashSize(_ data:@escaping ((String) ->Void)) {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskStorageSize{result in
            switch result {
            case .success(let value):
                let sizeM = Double(value) / 1024.0 / 1024.0
                data(String(format: "%.2fM", sizeM))
                break
            case .failure( _):
                data("0.00M")
                break
            }
            
        }
    }
    
    class func cleanCache(_ handler: @escaping (()->Void)){
        KingfisherManager.shared.cache.clearDiskCache{
            handler()
        }
    }
}
