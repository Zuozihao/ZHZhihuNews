//
//  NewsDetailViewController.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/26.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit
import JavaScriptCore

class NewsDetailViewController: UIViewController,UIScrollViewDelegate {

    var id:NSNumber!//新闻的id
    var scrollView: UIScrollView!
    @IBOutlet weak var toolBar: UIToolbar!
    private var webView: UIWebView!
    private var headImgView:UIImageView!
    private var kWidth:CGFloat = 0.0
    private var kHeight:CGFloat = 0.0
    let headerViewHight:CGFloat = 220
    var webViewHeight:CGFloat = 0.0
    var data:NSData!
    var webScrollView:UIScrollView!
    var imageView:UIImageView!
    var maskView:UIView!
    var dismissImageView:UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.kWidth = UIScreen.mainScreen().bounds.size.width
        self.kHeight = UIScreen.mainScreen().bounds.size.height
        self.webViewHeight = kHeight - 50 - headerViewHight
        initView()
        requestData()
        
    }
    
    func initView() {
        
        self.scrollView = UIScrollView.init(frame: CGRectMake(0,0, kWidth, kHeight - 50))
        self.view.addSubview(scrollView)
        
        self.scrollView.contentSize = CGSizeMake(kWidth, 2000)
        self.scrollView.tag = 1
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.scrollEnabled = true
        
        self.headImgView = UIImageView.init(frame: CGRectMake(0, 0, kWidth, headerViewHight))
        self.scrollView.addSubview(self.headImgView)
        self.headImgView.contentMode = .ScaleAspectFill
        self.headImgView.image = UIImage.init(named: "head2.jpg")
        
        let titleLabel:UILabel = UILabel.init(frame: CGRectMake(20, headImgView.frame.size.height - 30 - 45, kWidth - 40, 50))
        titleLabel.tag = 101;
        titleLabel.font = UIFont.boldSystemFontOfSize(19)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.shadowColor = UIColor.blueColor()
        titleLabel.shadowOffset = CGSizeMake(0.5, 0.5)
        titleLabel.numberOfLines = 0
        self.headImgView.addSubview(titleLabel)
        
        let sourceLabel:UILabel = UILabel.init(frame: CGRectMake(10, CGRectGetMaxY(titleLabel.frame), kWidth - 20, 18))
        sourceLabel.font = UIFont.systemFontOfSize(12)
        sourceLabel.textColor = UIColor.init(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
        sourceLabel.textAlignment = .Right
        sourceLabel.tag = 102
        self.headImgView.addSubview(sourceLabel)
        
        webView = UIWebView.init(frame: CGRectMake(0, headerViewHight, kWidth,kHeight - self.toolBar.frame.size.height))
        webView.scalesPageToFit = false//此处必须为false
        webView.tag = 2
        webView.delegate = self
        webView.scrollView.showsVerticalScrollIndicator = true
        self.webScrollView = webView.scrollView
        self.webScrollView.scrollEnabled = false
        self.webScrollView.delegate = self
        self.webScrollView.tag = 2
        scrollView.addSubview(webView)
        
        let imageArray:Array = ["News_Navigation_Arrow","News_Navigation_Next","News_Navigation_Vote","News_Navigation_Share","News_Navigation_Comment"]
        let selectedImageArray:Array = ["News_Navigation_Arrow_Highlight","News_Navigation_Next_Highlight","News_Navigation_Voted","News_Navigation_Share_Highlight","News_Navigation_Comment_Highlight"]
        
        let first:UIBarButtonItem = createToolBarbutton(CGRectMake(0, 0, 60, 40), imageName: imageArray[0], selectedImageName: selectedImageArray[0])
        let firstButton:UIButton = first.customView as! UIButton
        firstButton .addTarget(self, action: #selector(self.back), forControlEvents: .TouchUpInside)
        let second:UIBarButtonItem = createToolBarbutton(CGRectMake(0, 0, 60, 40), imageName: imageArray[1], selectedImageName: selectedImageArray[1])
        let third:UIBarButtonItem = createToolBarbutton(CGRectMake(0, 0, 60, 40), imageName: imageArray[2], selectedImageName: selectedImageArray[2])
        let fourth:UIBarButtonItem = createToolBarbutton(CGRectMake(0, 0, 60, 40), imageName: imageArray[3], selectedImageName: selectedImageArray[3])
        let fifth:UIBarButtonItem = createToolBarbutton(CGRectMake(0, 0, 60, 40), imageName: imageArray[4], selectedImageName: selectedImageArray[4])
        
        self.toolBar.items = [first,second,third,fourth,fifth]
        
    }
    
    func createToolBarbutton(frame:CGRect, imageName:String, selectedImageName:String) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: .Custom)
        button.frame = frame
        button.setImage(UIImage.init(named: imageName), forState: .Normal)
        button.setImage(UIImage.init(named: selectedImageName), forState: .Selected)
        let toolBarbuttonItem:UIBarButtonItem = UIBarButtonItem.init(customView: button)
        return toolBarbuttonItem
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func requestData() {
        let manager = NetWorkManager()
        let idString:String = (String)(self.id)
        manager.getNewsDetailWithId(idString) { (response, isok) in
            let responseData:NSDictionary = response as! NSDictionary
            let bodyData:String = responseData.objectForKey("body") as!String
            let cssArray:NSArray = responseData.objectForKey("css") as!NSArray
            let images:NSArray = responseData.objectForKey("images") as!NSArray
            let title:String = responseData.objectForKey("title") as! String
            let jsArray:NSArray = responseData.objectForKey("js") as!NSArray
            let ga_prefix:String = responseData.objectForKey("ga_prefix") as!String
            let type:NSNumber = responseData.objectForKey("type") as!NSNumber
            let id:NSNumber = responseData.objectForKey("id") as!NSNumber
            let shareURL:String = responseData.objectForKey("share_url") as!String
            let image:String = responseData.objectForKey("image") as!String
            let imageSorce:String = responseData.objectForKey("image_source") as! String
            
            let newsDetail = NewsDetail.init(body: bodyData, image_source: imageSorce, title: title, image: image, share_url: shareURL, js: jsArray, ga_prefix: ga_prefix, images: images, type: type, id: id, css: cssArray)
            let css:String = newsDetail.css.firstObject as! String
            let all:String = "<html><head><link rel=\"stylesheet\" href=\(css)</head><body>\(bodyData.stringByReplacingOccurrencesOfString("<div class=\"img-place-holder\"></div>", withString: ""))</body></html>"
            self.webView.loadHTMLString(all, baseURL: nil)
            
//            let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: s, action: <#T##Selector#>)
            
            let url:NSURL = NSURL.init(string: newsDetail.image)!
            let dispath = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(dispath, {
                () -> Void in
                let data:NSData = NSData.init(contentsOfURL: url)!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //刷新主UI
                    self.headImgView.image = UIImage.init(data: data, scale: 1.0)
                    let titleLabel:UILabel = self.headImgView.viewWithTag(101) as!UILabel
                    titleLabel.text = newsDetail.title
                    let sourceLabel:UILabel = self.headImgView.viewWithTag(102) as!UILabel
                    sourceLabel.text = "图片:  " + newsDetail.image_source
                })
            })

         
        }
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.tag == 1 {
             let y:CGFloat = self.scrollView.contentOffset.y
//            print("偏移量为\(y)")
            /**
             *  向下拉时要放大头部
             */
            if y < 0 {
                var headViewFrame = headImgView.frame
                headViewFrame.origin.y = y
                headViewFrame.size.height =  self.webView.frame.origin.y - y
                self.headImgView.frame = headViewFrame
                let titleLabel:UILabel = self.headImgView.viewWithTag(101) as!UILabel
                let sourceLabel:UILabel = self.headImgView.viewWithTag(102) as!UILabel
                titleLabel.frame = CGRectMake(20, headImgView.frame.size.height - 30 - 45, kWidth - 40, 50)
                sourceLabel.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame), kWidth - 20, 18)
                self.webScrollView.scrollEnabled = false
                self.scrollView.scrollEnabled = true
            }
            else if (y >= headerViewHight) {
                self.webScrollView.scrollEnabled = true
                self.scrollView.scrollEnabled = false
                self.scrollView.contentOffset.y = headerViewHight
            }

        } else if scrollView.tag == 2 {
            print(self.webScrollView.contentSize.height)
            let y:CGFloat = self.webScrollView.contentOffset.y
            print("网页偏移量\(y)")
            if scrollView.contentOffset.y <= 0 {
                self.scrollView.scrollEnabled = true
                self.webScrollView.scrollEnabled = false
            }

        }
        
}
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        self.evo_drawerController?.openDrawerGestureModeMask = .PanningNavigationBar
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        self.evo_drawerController?.leftDrawerViewController = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dimissImageViewAction() {
        UIView.animateWithDuration(0.5) {
            self.maskView.alpha = 0
            self.imageView.alpha = 0
            self.maskView.hidden = true
            self.imageView.hidden = true
        }
    }

}

extension NewsDetailViewController:UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        let jsGetImages:String = try!String.init(contentsOfFile: NSBundle.mainBundle().pathForResource("getImages", ofType: "txt")!)
        self.webView.stringByEvaluatingJavaScriptFromString(jsGetImages)
        let urlResult : String = webView.stringByEvaluatingJavaScriptFromString("getImages()")!
        print(urlResult)
        
        let clickAction : String = try!String.init(contentsOfFile: NSBundle.mainBundle().pathForResource("function", ofType: "txt")!)
        self.webView.stringByEvaluatingJavaScriptFromString(clickAction)
        self.webView.stringByEvaluatingJavaScriptFromString("registerImageClickAction();")
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        if !webView.loading  {
            let jsContext = self.webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext")
            jsContext?.setObject(JavaScriptMethod(), forKeyedSubscript: "callSwift")
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let scheme : String = (request.URL?.scheme)!
        
        if scheme == "image-preview" {
            let len:Int = "image-preview:".length
            let absoluteString :NSString = (request.URL?.absoluteString)! as NSString
            var path:String = absoluteString.substringFromIndex(len)
            path = path.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!//点击截取到的图片地址
            
            let window:UIWindow = ((UIApplication.sharedApplication().delegate?.window)!)!
            if self.maskView == nil {
                self.maskView = UIView.init(frame: window.frame)
                maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
                window .addSubview(maskView)
            }
            
            if self.imageView == nil {
                self.imageView = UIImageView.init(frame: CGRectMake(0, 0, window.frame.size.width, window.frame.size.height))
                self.imageView.contentMode = .ScaleAspectFit
                imageView.userInteractionEnabled = true
                maskView.insertSubview(imageView, aboveSubview: maskView)
                
                if dismissImageView == nil {
                    dismissImageView = UITapGestureRecognizer.init(target: self, action: #selector(self.dimissImageViewAction))
                    self.imageView .addGestureRecognizer(dismissImageView)
                }
            }
            
            
            let url : NSURL = NSURL.init(string: path)!
            
            let dispath = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
            dispatch_async(dispath, {
                () -> Void in
                let data:NSData = NSData.init(contentsOfURL: url)!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //刷新主UI
                    UIView.animateWithDuration(0.5, animations: {
                        self.maskView.alpha = 1
                        self.imageView.alpha = 1
                        self.maskView.hidden = false
                        self.imageView.hidden = false
                        self.imageView.image = UIImage.init(data: data, scale: 1.0)
                    })
                })
            })

            print(path)
            return false
        }
        
        return true
    }
}

@objc protocol JavaScriptMethodProtocol:JSExport {
    var value:String {get set}
    //对应JavaScript中callSwift.postContent方法
    func postContent(value: String, _number: String)
    
    func postContent(value: String, number: String)
    
}


class JavaScriptMethod : NSObject, JavaScriptMethodProtocol {
    
    var value: String {
        get { return ""}
        set {          }
    }
    
    func postContent(value: String, _number: String) {
        
    }
    
    func postContent(value: String, number: String) {
        
    }
}





