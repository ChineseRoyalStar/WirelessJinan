//
//  AppDelegate.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/6.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        AMapServices.sharedServices().apiKey = GDAPIKey
        
        self.window = UIWindow.init(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        
        self.window?.backgroundColor = UIColor.whiteColor()

        
        XHLaunchAd.showWithAdFrame(CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), setAdImage: { (launchAd) in
            
            
            /*
             http://pmobile.ijntv.cn/ijntv30/app.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&version_code=20160603&version=1.9.6&debug=0
             
             */
            
            let homeUrl = "http://pmobile.ijntv.cn/ijntv30/app.php"
            
            let para = ["appid":kAPPID,"appkey":kAPPKEY,"access_token":"","device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"207566","package_name":"com.hoge.android.jinan","version_code":"20160603","debug":"0"]
            
            let manager = AFHTTPSessionManager.init()
            
            manager.responseSerializer = AFHTTPResponseSerializer.init()
            
            manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
                
                let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let adImgDic = ((obj.objectForKey("ad") as! NSDictionary).objectForKey("before") as! NSDictionary).objectForKey("image") as! NSDictionary
                
                let imgUrl = (adImgDic.objectForKey("host") as! String) + (adImgDic.objectForKey("dir") as! String) + (adImgDic.objectForKey("filepath") as! String) + (adImgDic.objectForKey("filename") as! String)
                
                
                launchAd.setImageUrl(imgUrl, duration: 10, skipType: SkipType.TimeText, options: XHWebImageOptions.Default, completed: { (image, url) in
                    
                    }, click: {
                        
                        //点击图片的跳转
                        
                        
                })
                
            }) { (task, error) in
                
                //图片网络请求错误
                
            }
            
            
        }) {
            
            //广告展示完成回调
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: NSBundle.mainBundle())
            
            let rootVC = storyboard.instantiateViewControllerWithIdentifier("homePageViewController")
            
            self.window?.rootViewController = rootVC
            
        }
        
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

