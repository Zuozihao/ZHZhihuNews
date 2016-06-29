//
//  NewsDetail.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/5/11.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class NewsDetail: NSObject {
    
    var body:String!
    var image_source:String!//图片来源
    var title:String!
    var image:String!
    var share_url:String!
    var js:NSArray!
    var ga_prefix:String!
    var images:NSArray!
    var type:NSNumber!
    var id:NSNumber!
    var css:NSArray!
    
    init(body:String,image_source:String,title:String,image:String,share_url:String,js:NSArray,ga_prefix:String,images:NSArray,type:NSNumber,id:NSNumber,css:NSArray) {
        super.init()
        self.body = body
        self.image_source = image_source
        self.title = title
        self.image = image
        self.share_url = share_url
        self.js = js
        self.ga_prefix = ga_prefix
        self.images = images
        self.type = type
        self.id = id
        self.css = css
    }
}
