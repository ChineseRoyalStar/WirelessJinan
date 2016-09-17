//
//  RequestForPicAlbumData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension PictureModel {
    
    class func requestForPicAlbumData(homeUrl:String,offset:Int, callBack:(picModels:[AnyObject]?, error: NSError?)->Void) {
        
        /*
         http://pmobile.ijntv.cn/ijntv30/news_tp.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=20&offset=0&slide=1&num=5
         */
        
        /*
         http://pmobile.ijntv.cn/ijntv30/zt_news.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=20&offset=0&slide=1&num=5
         */
        
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"offset":String(offset),"count":"20","slide":"1","num":"5"]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            let modelArr = obj.valueForKey("list") as! NSArray
            
            let picModels = NSMutableArray()
            
            picModels.addObjectsFromArray(PictureModel.mj_objectArrayWithKeyValuesArray(modelArr) as [AnyObject])
            
            callBack(picModels: picModels as [AnyObject], error: nil)
            
        }) { (task, error) in
            
            callBack(picModels: nil, error: error)
            
        }
        
    }
    
    
    class func requestForTopicData(offset:Int, callBack:(topicModels:[AnyObject]?, error: NSError?)->Void) {
        

        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/zt_news.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"offset":String(offset),"count":"20","slide":"1","num":"5"]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            let modelArr = obj.valueForKey("list") as! NSArray
            
            let picModels = NSMutableArray()
            
            picModels.addObjectsFromArray(PictureModel.mj_objectArrayWithKeyValuesArray(modelArr) as [AnyObject])
            
            callBack(topicModels: picModels as [AnyObject], error: nil)
            
        }) { (task, error) in
            
            callBack(topicModels: nil, error: error)
            
        }
        
    }
    
}