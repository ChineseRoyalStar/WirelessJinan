//
//  RequestForVRChannelData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import AFNetworking

extension VRChannelModel {
    
    override class func requestForData(callBack:(titlesModels:[AnyObject]?, error: NSError?) -> Void)  {
        
        /*
         http://pmobile.ijntv.cn/ijntv30/v2_news_recomend_column.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&fid=
         */
        
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/v2_news_recomend_column.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"fid":""]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            let titlesModels = NSMutableArray()
            
            titlesModels.addObjectsFromArray(VRChannelModel.mj_objectArrayWithKeyValuesArray(obj) as [AnyObject])
            
            callBack(titlesModels: titlesModels as [AnyObject], error: nil)
            
            
        }) { (task, error) in
            
            callBack(titlesModels: nil, error: error)
            
        }
        
    }
    
}


extension VRListModel {
    
    class func requestForNewsData(vrModel:VRChannelModel,offset:Int,callBack:(newsArr: [AnyObject]?, ads: [AnyObject]?, error: NSError?)->Void) -> Void {
        /*
         http://pmobile.ijntv.cn/ijntv30/v2_news.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=20&offset=0&slide=1&num=5&column_id=235&column_name=%E5%B9%BF%E7%94%B5VR%E7%A7%80
         */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/v2_news.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"access_token":"","device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"207566","package_name":"com.hoge.android.jinan","app_type":"android","count":"20","offset":String(offset),"column_id":vrModel.id,"column_name":vrModel.name.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.init(charactersInString:vrModel.name))!]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let newsArr = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            //获取版块顶部图片URL
            let adsArr = obj.objectForKey("slide") as! NSArray
            
            var ads = NSMutableArray()
            
            if adsArr.count > 0 {
                
                ads = NewsModel.mj_objectArrayWithKeyValuesArray(adsArr)
                
            }
            
            //获取模型数组
            let modelsArr = obj.valueForKey("list") as! [AnyObject]
            
            newsArr.addObjectsFromArray(VRListModel.mj_objectArrayWithKeyValuesArray(modelsArr) as [AnyObject])
            
            callBack(newsArr: newsArr as [AnyObject], ads: ads as [AnyObject], error: nil)
            
        }) { (task, error) in
            
            callBack(newsArr: nil, ads: nil, error: error)
            
        }
        
    }
    
}