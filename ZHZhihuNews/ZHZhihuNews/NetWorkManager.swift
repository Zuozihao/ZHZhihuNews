//
//  NetWorkManager.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/28.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit
import Alamofire

private let shareManager = NetWorkManager()

let getNewsListAddress:String = "http://news-at.zhihu.com/api/4/news/latest"
let getNewsDetailAddress:String = "http://news-at.zhihu.com/api/4/news/"

class NetWorkManager: NSObject {
    
    static let shareInstance = NetWorkManager()
    
    func getRequest(pre:(response:AnyObject,isok:Bool) -> Void) {
        Alamofire.request(.GET, getNewsListAddress).responseJSON {
            (response) in
           
            if response.result.isSuccess == true {
                 pre(response: response.result.value!,isok: true)
            } else {
                pre(response: [], isok: false)
            }
            
        }

    }
    
    
    func getNewsDetailWithId(id:String,pre:(response:AnyObject,isok:Bool) -> Void) {
        let url = getNewsDetailAddress + id
        Alamofire.request(.GET, url).responseJSON {
            (response) in
            
            if response.result.isSuccess == true {
                pre(response: response.result.value!,isok: true)
            } else {
                pre(response: [], isok: false)
            }
            
        }
        
    }

    
}



