//
//  LeftTableView.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/25.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class LeftTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    let array:Array = ["首页","电影日报","日常心理学","用户推荐日报","不许无聊","设计日报","大公司日报","财经日报","互联网安全","开始游戏","音乐日报","动漫日报","体育日报"]

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
   override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        self.separatorStyle = .None
        self.showsVerticalScrollIndicator = false
    
        let nib:UINib = UINib.init(nibName: "LeftTableViewCell", bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: "LeftTableViewCell")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if indexPath.row == 0 {
//            let cell:UITableViewCell = UITableViewCell.init(style: .Default, reuseIdentifier: "LeftCell")
//            cell.imageView?.image = UIImage.init(named: "Menu_Icon_Home")
//            cell.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
//            cell.textLabel?.font = UIFont.systemFontOfSize(14)
//            cell.textLabel?.textColor = UIColor.lightGrayColor()
//            cell.textLabel?.text = array[indexPath.row]
//            cell.accessoryType = .DisclosureIndicator
//            return cell
//        }
        
        
        var cell: LeftTableViewCell! = tableView.dequeueReusableCellWithIdentifier("LeftTableViewCell") as! LeftTableViewCell?
        
        if cell == nil {
            cell = LeftTableViewCell(style: .Default, reuseIdentifier: "LeftTableViewCell")
            cell.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        }
        
        if indexPath.row == 0 {
            cell.imageView?.image = UIImage.init(named: "Menu_Icon_Home")
            cell.textLabel?.font = UIFont.systemFontOfSize(14)
            cell.textLabel?.textColor = UIColor.lightGrayColor()
            cell.textLabel?.text = array[indexPath.row]
            cell.cellButton.setImage(UIImage.init(named: "Menu_Enter"), forState: .Normal)
            cell.cellButton.frame = CGRectMake(280 - 15 - 10, 5, 20, 20)
//            cell.cellButton.setBackgroundImage(UIImage.init(named: "Menu_Enter"), forState: .Normal)
            return cell
        }
        
        cell.cellLabel.text = array[indexPath.row]

        return cell
    }
}
