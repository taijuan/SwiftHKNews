//
//  Alamofire.swift
//  SwiftHKNews
//
//  Created by 郑泰捐 on 2019/9/6.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Alamofire
extension DataRequest{
    func responseString()->AFDataResponse<String>{
        print("1111111111")
        let semaphore = DispatchSemaphore(value: 0)
        var result:AFDataResponse<String>!
        self.responseString(queue: DispatchQueue.global(qos: .default), completionHandler:  {(response) in
            print("22222222222")
            result = response
            semaphore.signal()
        })
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        print("3333333333")
        return result
    }
}
