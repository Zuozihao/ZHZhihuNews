//
//  LoginViewController.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/23.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    func initView() {
        let back:UIButton = UIButton.init(type: .Custom)
        back.frame = CGRectMake(0, 0, 30, 20)
        back.titleLabel?.font = UIFont.systemFontOfSize(14)
        back.setTitle("取消", forState: .Normal)
        back.setTitleColor(UIColor.grayColor(), forState: .Normal)
        back.addTarget(self, action: #selector(LoginViewController.dismissVC), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: back)
    }
    
    func dismissVC() {
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
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
