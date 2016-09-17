//
//  WebPagePresentationViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import AVKit

import AVFoundation

import MBProgressHUD

class WebPagePresentationViewController: UIViewController, UIWebViewDelegate, AVPlayerViewControllerDelegate{
    
    var contentUrl: String!
    
    var webView: UIWebView!
    
    var playerVC: AVPlayerViewController!
    
    lazy var progressHud: MBProgressHUD = {
        
        let progress = MBProgressHUD.init(frame: CGRectMake(0, 0, 200, 200))
        
        progress.center = self.view.center
        
        self.view.addSubview(progress)
        
        return progress
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        if contentUrl.hasSuffix(".html") {
        
            self.createWebPage()
        
        }else if self.contentUrl.hasSuffix(".mp4") && self.contentUrl.hasPrefix("vr?") || self.contentUrl.hasSuffix("m3u8"){
            
            self.createAVPlayer()
            
        }
        
    }

    func createWebPage() {
        
        self.webView = UIWebView.init(frame: CGRectMake(0, 15, kSCREEN_W, kSCREEN_H-15))
        
        self.webView.delegate = self
        
        let request = NSURLRequest.init(URL: NSURL.init(string: self.contentUrl)!)
        
        self.webView.loadRequest(request)
        
        self.view.addSubview(webView)
    
    }
    
    func createAVPlayer() {
        
        let videoUrl = (contentUrl as NSString).componentsSeparatedByString("=").last!
        
        self.playerVC = AVPlayerViewController.init()
        
        self.playerVC.player = AVPlayer.init(URL: NSURL.init(string: videoUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!)
        
        self.playerVC.view.frame = self.view.bounds
        
      //  self.playerVC.delegate = self
        
        self.view.addSubview(playerVC.view)
        
        self.playerVC.player?.play()
        
    }
    
    //MARK:- UIWebViewDelegate Methods
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        self.progressHud.showAnimated(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.progressHud.hideAnimated(true)
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        self.progressHud.hideAnimated(true)
        
        let alert = UIAlertController.init(title: "警告", message: "网页加载失败", preferredStyle: .Alert)
        
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK:- AVPlayerViewControllerDelegate Methods
    
    func playerViewControllerWillStartPictureInPicture(playerViewController: AVPlayerViewController) {
        
        self.progressHud.hideAnimated(true)
    
    }
    
    func playerViewControllerDidStartPictureInPicture(playerViewController: AVPlayerViewController) {
        
        self.progressHud.hideAnimated(true)
    }
    
    func playerViewController(playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: NSError) {
        
        let alert = UIAlertController.init(title: "警告", message: "视频加载失败", preferredStyle: .Alert)
        
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
