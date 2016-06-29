//
//  LeftViewController.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/22.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        let headView:UIView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 122))
        headView.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        headView.layer.borderColor = UIColor.blackColor().CGColor
        headView.layer.borderWidth = 0.3

        self.view.addSubview(headView)
        let avtarView : UIImageView = UIImageView.init(frame: CGRectMake(15,30, 30, 30))
        avtarView.image = UIImage.init(named: "Dark_Menu_Avatar")
        headView.addSubview(avtarView)
        
        let logInButton:UIButton = UIButton.init(type: .Custom)
        logInButton.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        logInButton.frame = CGRectMake(CGRectGetMaxX(avtarView.frame), 30, 80, 30)
        logInButton.setTitle("请登录", forState: .Normal)
        logInButton.addTarget(self, action: #selector(LeftViewController.goLogin), forControlEvents: .TouchUpInside)
        logInButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        logInButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        headView.addSubview(logInButton)
        
//        Dark_Menu_Icon_Setting@2x
        //抽屉宽度为默认宽度280
        let collection:UIButton = UIButton.init(type: .Custom)
        collection.frame = CGRectMake(15, CGRectGetMaxY(avtarView.frame)+20, 20, 20)
        collection.setBackgroundImage(UIImage.init(named: "Dark_Menu_Icon_Collect"), forState: .Normal)
        headView.addSubview(collection)
        
        let msg:UIButton = UIButton.init(type: .Custom)
        msg.frame = CGRectMake(280/2.0 - 10, CGRectGetMaxY(avtarView.frame)+20, 20, 20)
        msg.setBackgroundImage(UIImage.init(named: "Dark_Menu_Icon_Message"), forState: .Normal)
        headView.addSubview(msg)
        
        let setting:UIButton = UIButton.init(type: .Custom)
        setting.frame = CGRectMake(280 - 10 - 20, CGRectGetMaxY(avtarView.frame)+20, 20, 20)
        setting.setBackgroundImage(UIImage.init(named: "Dark_Menu_Icon_Setting"), forState: .Normal)
        headView.addSubview(setting)
        
        let label1: UILabel = UILabel.init(frame: CGRectMake(15, CGRectGetMaxY(collection.frame), 30, 15))
        label1.textColor = UIColor.grayColor()
        label1.text = "收藏"
        label1.font = UIFont.systemFontOfSize(10)
        headView.addSubview(label1)
        
        let label2: UILabel = UILabel.init(frame: CGRectMake(280/2.0 - 10, CGRectGetMaxY(collection.frame), 30, 15))
        label2.textColor = UIColor.grayColor()
        label2.text = "消息"
        label2.font = UIFont.systemFontOfSize(10)
        headView.addSubview(label2)
        
        let label3: UILabel = UILabel.init(frame: CGRectMake(280 - 10 - 20, CGRectGetMaxY(collection.frame), 30, 15))
        label3.textColor = UIColor.grayColor()
        label3.text = "设置"
        label3.font = UIFont.systemFontOfSize(10)
        headView.addSubview(label3)
        
        let leftTableView:LeftTableView = LeftTableView.init(frame: CGRectMake(0, CGRectGetMaxY(headView.frame), 280, self.view.frame.size.height - headView.frame.size.height), style: .Plain)
        self.view.addSubview(leftTableView)
        
    }
    
    func goLogin() {
        let vc = LoginViewController()
        let navigation = UINavigationController.init(rootViewController: vc)
        self.presentViewController(navigation, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
