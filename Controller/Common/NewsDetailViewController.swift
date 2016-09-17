//
//  NewsViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/12.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import AFNetworking

import AVFoundation

import AVKit

import MBProgressHUD

class NewsDetailViewController: UIViewController,UIWebViewDelegate {
    
    var contentId: String?
    
    var progress: MBProgressHUD?
    
    var webView: UIWebView?
    
    var gossipListIds = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //MBProgressHUD
        progress = MBProgressHUD.init(frame: CGRectMake(0, 0, 200, 200))
        
        self.view.addSubview(progress!)
        
        progress?.center = self.view.center
        
        progress?.detailsLabel.text = "Loading..."
        
        self.progress?.showAnimated(true)
        
        self.requestForUrl()
        
        // Do any additional setup after loading the view.
    }
    
    func requestForUrl() {
        
        /*
         http://pmobile.ijntv.cn/ijntv30/item.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=2d3f6d9112b440a77b78bc09b442a8eb&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&id=87318
         */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/item.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"","package_name":"com.hoge.android.jinan","id":self.contentId!]
        
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters:para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            let url = obj.valueForKey("content_url") as! String
            
            if url.hasSuffix(".html") {
                
                let request = NSURLRequest.init(URL: NSURL.init(string: url)!)
                
                self.webView = UIWebView()
                
                self.webView?.frame = CGRectMake(0, 15, kSCREEN_W, kSCREEN_H-15)
                
                self.view.addSubview(self.webView!)
                
                self.webView?.loadRequest(request)
                
                self.webView?.delegate = self
                
            }else if url.hasSuffix(".mp4") && url.hasPrefix("vr?") {
                
                let videoUrl = (url as NSString).componentsSeparatedByString("=").last!
                
                let playerVC = AVPlayerViewController.init()
                
                playerVC.player = AVPlayer.init(URL: NSURL.init(string: videoUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!)
                
                playerVC.view.frame = self.view.bounds
                
                self.view.addSubview(playerVC.view)
            
                playerVC.player?.play()
                
            }

            
        }) { (task, error) in
            
            let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
            
            let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    //MARK: - UIWebView Delegate Methods
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.progress?.hideAnimated(true)
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        self.progress?.hideAnimated(true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



