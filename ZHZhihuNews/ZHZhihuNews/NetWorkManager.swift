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
let getNewsBeforeAddress:String = "http://news-at.zhihu.com/api/4/news/before/"

class NetWorkManager: NSObject {
    
    static let shareInstance = NetWorkManager()
    /**
     首页最新的新闻
     
     - parameter pre: 闭包
     */
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
    
    /**
     获取新闻详情
     
     - parameter id:  传入新闻的id
     - parameter pre: 闭包
     */
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
    
    /**
     获取之前的
     
     - parameter date: 传入的日期,需要传入后一天 如获取2016年7月1号需传入20160702
     - parameter pre:  闭包
     */
    func getNewsBeforeWithDate(date:String,pre:(response:AnyObject, isok:Bool) -> Void) {
        let url = getNewsBeforeAddress + date
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



