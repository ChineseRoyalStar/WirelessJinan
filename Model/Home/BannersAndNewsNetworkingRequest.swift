//
//  AdvertisementNetworkingRequest.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension BannerAndNewsModel {
    
    
    class func requestForAdvertisementAndNewsData(callBack:(ads:[AnyObject]?,news:[[AnyObject]]?,error:NSError?) -> Void) {
        
        /*
        http://pmobile.ijntv.cn/ijntv30/card.php?appid=7&appkey=d&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.home.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=&app_type=android
        
        */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/card.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"","package_name":"com.hoge.android.jinan","app_type":"android"]
        
        
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let adsArr = NSMutableArray()
            
            var newsArr = Array.init(count: 6, repeatedValue: [AnyObject]())
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .MutableContainers) as! NSArray
            
            
            for i in 0...obj.count-1 {
                
                let dic = obj[i] as! NSDictionary
                
                let contentArr = dic["content"] as! [AnyObject]
                
                
                if i == 0 {
                    
                    let contentDic = contentArr[0] as! NSDictionary
                    
                    let childsArr = contentDic["childs_data"] as! [AnyObject]
                    
                    let ads = ChildModel.mj_objectArrayWithKeyValuesArray(childsArr) as [AnyObject]
                    
                    adsArr.addObjectsFromArray(ads)
                    
                    
                }else {
                    
                    let modelArr = BannerAndNewsModel.mj_objectArrayWithKeyValuesArray(contentArr) as [AnyObject]
                    
                    for model in modelArr {
                        
                        newsArr[i-1].append(model)
                        
                    }
                    
                }
                
            }
            
                callBack(ads: adsArr as [AnyObject], news: newsArr as [[AnyObject]], error:nil)
            
        }) { (task, error) in
            
                callBack(ads: nil, news: nil, error: error)
            
        }
        
        
    }
    
}