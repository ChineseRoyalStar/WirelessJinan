//
//  RequestForNewsData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/13.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

class RequestForNewsData {
    
    
    class func requestForNewsData(boardIndex:Int,offset:Int,callBack:(newsArr: [AnyObject]?,title:NewsModel?, error: NSError?)->Void) -> Void {
        
        
        /*
         http://pmobile.ijntv.cn/ijntv30/news.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=20&offset=20&column_id=3&column_name=济南
         */
        
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/news.php?"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"access_token":"","device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"207566","package_name":"com.hoge.android.jinan","app_type":"android","count":"20","offset":String(offset),"column_id":kCOLUMNID[boardIndex],"column_name":kBOARDS[boardIndex].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.init(charactersInString:kBOARDS[boardIndex]))!]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let newsArr = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            //获取版块顶部图片URL
            let adsArr = obj.objectForKey("slide") as! NSArray
            
            var titleModel: NewsModel?
            
            if adsArr.count > 0 {
                
               titleModel = NewsModel.mj_objectWithKeyValues(adsArr.objectAtIndex(0))
                
            }
            
            //获取模型数组
            let modelsArr = obj.valueForKey("list") as! [AnyObject]
            
            newsArr.addObjectsFromArray(NewsModel.mj_objectArrayWithKeyValuesArray(modelsArr) as [AnyObject])
            
            
            callBack(newsArr: newsArr as [AnyObject], title: titleModel, error: nil)
            
        }) { (task, error) in
            
            callBack(newsArr: nil, title:nil, error: error)
            
        }

    }

}