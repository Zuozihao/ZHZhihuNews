//
//  CenterViewController.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/22.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    var tableView:UITableView!
    let headerViewHight:CGFloat = 220
    var headView:UIView!
    var myScrollView:UIScrollView!
    var timer:NSTimer!
    var dataArray:[NewsListModel]!
    var topStoriesArray:[NewsListModel]!
    var coutArray:[Int]!//存放每日数量的数组
    var dateArray:[String]!//存放日期的数组
    //导航栏高度44 状态栏高度20
    
    var pageView:UIPageControl!
    var date:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyanColor()
        dataArray = []
        topStoriesArray = []
        coutArray = []
        dateArray = []
        initView()
        requestData()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:创建视图
    func initView() {
        self.title = "今日热闻"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()];
        
        let navButton: UIButton = UIButton.init(type:.Custom)
        navButton.frame = CGRectMake(0, 0,20, 20);
        navButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        navButton.backgroundColor = UIColor.clearColor()
        navButton.setBackgroundImage(UIImage.init(named: "Home_Icon"), forState: .Normal)
        navButton.setBackgroundImage(UIImage.init(named: "Home_Icon_Highlight"), forState: .Highlighted)
        
        navButton.addTarget(self, action: #selector(CenterViewController.goLeftVC), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navButton)
        
        let rect : CGRect = CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height + 64)
        self.tableView = UITableView.init(frame: rect, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(headerViewHight, 0, 0, 0)
        tableView.tag = 1
        
        let nib:UINib = UINib.init(nibName: "NewsCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "tableViewCell")
        
        //头部轮播图
        myScrollView = UIScrollView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, headerViewHight))
        myScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 7, headerViewHight)
        myScrollView.pagingEnabled = true
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.tag = 2
        myScrollView.delegate = self
        
        headView = UIView.init(frame: CGRectMake(0, (-headerViewHight), self.view.frame.size.width, headerViewHight))
        
        tableView.addSubview(headView)
        headView.addSubview(myScrollView)
        
        let imgs:Array = ["head5.jpg","head1.jpeg","head2.jpg","head3.jpg","head4.jpg","head5.jpg","head1.jpeg"]
        
        for i:Int in 0..<7 {
            let imageView:UIImageView = UIImageView.init(frame: CGRectMake(self.view.frame.size.width * (CGFloat)(i), 0, self.view.frame.size.width, headerViewHight))
            let imgName:String = imgs[i]
            imageView.image = UIImage.init(named: imgName)
            imageView.tag = i+100
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            myScrollView.addSubview(imageView)
            
            let titleLabel:UILabel = UILabel.init(frame: CGRectMake(20,imageView.frame.size.height - 30 - 45, self.view.frame.size.width - 40, 50))
            titleLabel.tag = i + 1000
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFontOfSize(19)
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.shadowColor = UIColor.blackColor()
            titleLabel.shadowOffset = CGSizeMake(0.5, 0.5)
            titleLabel.text = "魏则西时间的持续发酵,会对百度股价造成什么影响?"
            imageView.addSubview(titleLabel)
        }
        
        myScrollView.contentOffset.x = self.view.frame.size.width
        
        pageView = UIPageControl.init(frame: CGRectMake(self.view.frame.size.width / 2 - 50, headView.frame.size.height - 30, 100, 30))
        pageView.numberOfPages = 5
        headView.addSubview(pageView)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(CenterViewController.scrollHeadViewWithTimer), userInfo: nil, repeats: true)
        
    }
    
    func scrollHeadViewWithTimer() {
        
        let page:Int = self.pageView.currentPage
        
        if page == 4 {
            self.pageView.currentPage = 0
            
           UIView .animateWithDuration(0.3, animations: {
            self.myScrollView.contentOffset.x = self.view.frame.size.width * 6
           })
            self.myScrollView.contentOffset.x = self.view.frame.size.width * 1
        } else {
            UIView.animateWithDuration(0.3) {
                    self.pageView.currentPage = page + 1
                    self.myScrollView.contentOffset.x = (CGFloat)(self.pageView.currentPage + 1) * self.view.frame.size.width
            }
        }
        
    }
    
    //MARK:UITableViewDataSource & UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coutArray[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "tableViewCell"
        
        var cell: NewsCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! NewsCell?
        
        if cell == nil {
            cell = NewsCell(style: .Default, reuseIdentifier: CellIdentifier)
            cell.selectionStyle = .Gray
        }
        
        let section:Int = indexPath.section
        var allBefore:Int = 0
        
        var newsModel:NewsListModel!
        
        if section == 0 {
            newsModel = dataArray[indexPath.row]
        } else {
            for i:Int in 0..<section {
                allBefore += self.coutArray[i]
            }
            newsModel = dataArray[indexPath.row + allBefore]
        }
        
//        let newsModel:NewsListModel = dataArray[indexPath.row]
        
        if self.dataArray.count > 0 {
            cell.titleLabel.text = newsModel.titile
            
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(19)
            let url:NSURL = NSURL.init(string: newsModel.imageURL)!
            
            let dispath = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(dispath, { 
                () -> Void in
                let data:NSData = NSData.init(contentsOfURL: url)!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //刷新主UI
                    cell.imgView.image = UIImage.init(data: data, scale: 1.0)
                })
            })
            
        }

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return coutArray.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = NewsDetailViewController()
        
        var allBefore:Int = 0
        var newsModel:NewsListModel!
        
        if indexPath.section == 0 {
            newsModel = dataArray[indexPath.row]
        } else {
            for i:Int in 0..<indexPath.section {
                allBefore += self.coutArray[i]
            }
            newsModel = dataArray[indexPath.row + allBefore]
        }

        
        vc.id = newsModel.id
        vc.navigationController?.navigationBar.hidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let head : UILabel = UILabel.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 25))
            head.backgroundColor = UIColor.init(red: 64/255.0, green: 175/255.0, blue: 255/255.0, alpha: 1)
            var currentDate:String = dateArray[section]
            let year:String = (currentDate as NSString).substringWithRange(NSMakeRange(0, 4))
            let month:String = (currentDate as NSString).substringWithRange(NSMakeRange(4, 2))
            let day:String = (currentDate as NSString).substringWithRange(NSMakeRange(6, 2))
            currentDate = year+"-"+month+"-"+day
            let week:Int = getWeekDay(currentDate)
            print("这是星期",week);
            
            let weekDay:String = getChineseWeekDay(week)
            head.text = month+"月"+day+"日"+"     星期"+weekDay
            head.textColor = UIColor.whiteColor()
            head.textAlignment = .Center
            return head;
        }
        
        let head : UILabel = UILabel.init(frame: CGRectZero)
        return head
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        
        return  40;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.tag == 1 {
            print("开始滑动")
            let offSetY:CGFloat = scrollView.contentOffset.y
            
            let navHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
            
            print(offSetY)
            
            print(navHeight)
            
            if offSetY>(-284) {
                
                var alpha : CGFloat!
                
                alpha = 1 - (156 - (284+offSetY))/156
                
                print(alpha)
                self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 64/255.0, green: 175/255.0, blue: 255/255.0, alpha: 1)
                let array:Array = (self.navigationController?.navigationBar.subviews)!
                array.first?.alpha = alpha
            } else {
                self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
                let array:Array = (self.navigationController?.navigationBar.subviews)!
                array.first?.alpha = 0.0
            }
            
            let y : CGFloat = tableView.contentOffset.y + 64
            if y < (-headerViewHight) {
                
                
                var headViewFrame = headView.frame
                headViewFrame.origin.y = y
                headViewFrame.size.height = -y
                headView.frame = headViewFrame
                
                var scrollViewFrame:CGRect = myScrollView.frame
                scrollViewFrame.size.height = headView.frame.size.height
                myScrollView.frame = scrollViewFrame
                
                let x:CGFloat = myScrollView.contentOffset.x
                let page:Int = (Int)(x/self.view.frame.width)
                print(page)
                
                let imageView = myScrollView.viewWithTag(page+100)
                print(imageView?.tag)
                
                let titleLabel:UILabel = imageView?.subviews.first as! UILabel
                var titleLabelFrame:CGRect = titleLabel.frame
                titleLabelFrame.origin.y = myScrollView.frame.size.height - 30 - 45
                titleLabel.frame = titleLabelFrame
                
                var frame:CGRect = imageView!.frame
                frame.size.height = myScrollView.frame.size.height
                imageView!.frame = frame
                
                pageView.frame = CGRectMake(self.view.frame.size.width / 2 - 50, headView.frame.size.height - 30, 100, 30)
            }

        }
        
        else if scrollView.tag == 2 {
            print("头部视图滑动")
            let x:CGFloat = scrollView.contentOffset.x
            let page:Int = (Int)(x/self.view.frame.width)
            print(page)
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag == 2 {
            let x:CGFloat = scrollView.contentOffset.x
            let page:Int = (Int)(x/self.view.frame.width)
            print(page)
            
            if page == 6 {
                myScrollView.contentOffset.x = self.view.frame.size.width
                pageView.currentPage = 0
            } else if page == 0 {
                myScrollView.contentOffset.x = self.view.frame.size.width * 5
                pageView.currentPage = 4
            } else {
                pageView.currentPage = page - 1
            }
        }
    }
    
    //MARK:进入详情页面
    func goLeftVC() {
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    //MARK:请求数据
    func requestData() {
        let manager = NetWorkManager()
        manager.getRequest({
            (response:AnyObject,isOk:Bool) in
            
            if isOk == true {
                let dic:NSDictionary = response as! NSDictionary
                
                self.date = dic.objectForKey("date") as! String
                self.dateArray.append(self.date)
                
                //新闻列表
                let stories:NSArray = dic.objectForKey("stories") as! NSArray
                self.coutArray.append(stories.count)
            
                for i:Int in 0..<stories.count {
                    
                    let story : NSDictionary = stories[i] as! NSDictionary
                    
                    let imgURLArray:NSArray = story.objectForKey("images") as! NSArray
                    let imgURL:String = imgURLArray.firstObject as! String
                    let type:NSNumber = story.objectForKey("type") as! NSNumber
                    let id:NSNumber = story.objectForKey("id") as! NSNumber
                    let ga_prefix:String = story.objectForKey("ga_prefix") as! String
                    let title:String = story.objectForKey("title") as! String
                    
                    let model:NewsListModel = NewsListModel.init(imageURL: imgURL, type:type, id: id, ga_prefix: ga_prefix, titile: title)
                    
                    self.dataArray.append(model)
                }
                
                //顶部新闻列表
                let topStories:NSArray = dic.objectForKey("top_stories") as! NSArray
                
                for i:Int in 0..<topStories.count {
                    let story : NSDictionary = topStories[i] as! NSDictionary
                    
                    let imgURL:String = story.objectForKey("image") as! String
                    let type:NSNumber = story.objectForKey("type") as! NSNumber
                    let id:NSNumber = story.objectForKey("id") as! NSNumber
                    let ga_prefix:String = story.objectForKey("ga_prefix") as! String
                    let title:String = story.objectForKey("title") as! String
                    
                    let model:NewsListModel = NewsListModel.init(imageURL: imgURL, type:type, id: id, ga_prefix: ga_prefix, titile: title)
                    
                    self.topStoriesArray.append(model)

                }
                
                manager.getNewsBeforeWithDate(self.date, pre: { (response, isok) in
                    if isOk == true {
                        let dic:NSDictionary = response as! NSDictionary
                        
                        self.date = dic.objectForKey("date") as! String
                        self.dateArray.append(self.date)
                        
                        //新闻列表
                        let stories2:NSArray = dic.objectForKey("stories") as! NSArray
                        
                        self.coutArray.append(stories2.count)
                        
                        for i:Int in 0..<stories2.count {
                            
                            let story : NSDictionary = stories2[i] as! NSDictionary
                            
                            let imgURLArray:NSArray = story.objectForKey("images") as! NSArray
                            let imgURL:String = imgURLArray.firstObject as! String
                            let type:NSNumber = story.objectForKey("type") as! NSNumber
                            let id:NSNumber = story.objectForKey("id") as! NSNumber
                            let ga_prefix:String = story.objectForKey("ga_prefix") as! String
                            let title:String = story.objectForKey("title") as! String
                            
                            let model:NewsListModel = NewsListModel.init(imageURL: imgURL, type:type, id: id, ga_prefix: ga_prefix, titile: title)
                            
                            self.dataArray.append(model)
                        }
                        
                        manager.getNewsBeforeWithDate(self.date, pre: { (response, isok) in
                            if isok == true {
                                let dic:NSDictionary = response as! NSDictionary
                                
                                self.date = dic.objectForKey("date") as! String
                                self.dateArray.append(self.date)
                                
                                //新闻列表
                                let stories3:NSArray = dic.objectForKey("stories") as! NSArray
                                
                                self.coutArray.append(stories3.count)
                                
                                for i:Int in 0..<stories3.count {
                                    
                                    let story : NSDictionary = stories3[i] as! NSDictionary
                                    
                                    let imgURLArray:NSArray = story.objectForKey("images") as! NSArray
                                    let imgURL:String = imgURLArray.firstObject as! String
                                    let type:NSNumber = story.objectForKey("type") as! NSNumber
                                    let id:NSNumber = story.objectForKey("id") as! NSNumber
                                    let ga_prefix:String = story.objectForKey("ga_prefix") as! String
                                    let title:String = story.objectForKey("title") as! String
                                    
                                    let model:NewsListModel = NewsListModel.init(imageURL: imgURL, type:type, id: id, ga_prefix: ga_prefix, titile: title)
                                    
                                    self.dataArray.append(model)
                                }
                                
                                //刷新新闻列表
                                self.tableView.reloadData()

                            }
                        })
                        

                    }
                })
                //刷新顶部新闻列表
                let firstImgView:UIImageView = self.myScrollView.viewWithTag(100) as!UIImageView
                let url:NSURL = NSURL.init(string: self.topStoriesArray.last!.imageURL)!
                let titleLabel:UILabel = firstImgView.subviews.first as! UILabel
                titleLabel.text = self.topStoriesArray[0].titile
                let dispath = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                dispatch_async(dispath, {
                    () -> Void in
                    let data:NSData = NSData.init(contentsOfURL: url)!
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //刷新主UI
                        firstImgView.image = UIImage.init(data: data, scale: 1.0)
                    })
                })
                
                let lastImgView:UIImageView = self.myScrollView.viewWithTag(106) as!UIImageView
                let url2:NSURL = NSURL.init(string: self.topStoriesArray.first!.imageURL)!
                let titleLabel2:UILabel = firstImgView.subviews.first as! UILabel
                titleLabel2.text = self.topStoriesArray.first!.titile
                let dispath2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                dispatch_async(dispath2, {
                    () -> Void in
                    let data:NSData = NSData.init(contentsOfURL: url2)!
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        //刷新主UI
                        lastImgView.image = UIImage.init(data: data, scale: 1.0)
                    })
                })

                for i:Int in 0..<self.topStoriesArray.count {
                    let imgView:UIImageView = self.myScrollView.viewWithTag(i+100+1) as!UIImageView
                    
                    let url:NSURL = NSURL.init(string: self.topStoriesArray[i].imageURL)!
                    let titleLabel:UILabel = imgView.subviews.first as! UILabel
                    titleLabel.text = self.topStoriesArray[i].titile
                    let dispath = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                    dispatch_async(dispath, {
                        () -> Void in
                        let data:NSData = NSData.init(contentsOfURL: url)!
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            //刷新主UI
                           imgView.image = UIImage.init(data: data, scale: 1.0)
                        })
                    })
                }
            }
        })
        
    }
    
    func getChineseWeekDay(weekday:Int) -> String {
        if weekday==1 {
            return "一"
        } else if weekday==2 {
            return "二"
        } else if weekday==3 {
            return "三"
        } else if weekday==4 {
            return "四"
        } else if weekday==5 {
            return "五"
        } else if weekday==6 {
            return "六"
        }
        return "日"
    }
    
    func getWeekDay(dateTime:String)->Int{
        let dateFmt = NSDateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.dateFromString(dateTime)
        date?.description
        let interval = Int(date!.timeIntervalSince1970) + NSTimeZone.localTimeZone().secondsFromGMT
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    
    //MARK:重载方法
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        let array:Array = (self.navigationController?.navigationBar.subviews)!
        array.first?.alpha = 0.0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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
