//
//  NewsList.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/28.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class NewsListModel: NSObject {
    
    var imageURL:String!
    var type:NSNumber!
    var id:NSNumber!
    var ga_prefix:String!
    var titile:String!
    
    init(imageURL: String, type: NSNumber,id: NSNumber,ga_prefix: String,titile: String ) {
        super.init()
        self.imageURL = imageURL
        self.type = type
        self.id = id
        self.ga_prefix = ga_prefix
        self.titile = titile
    }
    

}
