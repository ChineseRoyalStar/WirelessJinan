//
//  RequestForTopicAndBannerData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension BannerModel {
    
    class func requestForBannerData(id:String, callBack:(bannerModel:BannerModel?, error: NSError?)->Void) {
        
        /*
         http://pmobile.ijntv.cn/ijntv30/special_detail.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&id=257
         */
        
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/special_detail.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"id":id]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            let bannerModel = BannerModel.mj_objectWithKeyValues(obj.objectAtIndex(0) as! NSDictionary)
            
            callBack(bannerModel:bannerModel, error: nil)
            
        }) { (task, error) in
            
            callBack(bannerModel: nil, error: error)
            
        }
    }
    
}


extension TopicModel {
    
    class func requestForTopicData(id: String, offset: Int, callBack:(sectionTitleArr:[AnyObject]?, sectionDataSource:[AnyObject]?, error: NSError?)->Void) {
        
        /*
         http://pmobile.ijntv.cn/ijntv30/special_content.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&column_id=257&offset=0
         */
        
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/special_content.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"column_id":id,"offset":String(offset)]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            let topicModels = NSMutableArray()
            
            topicModels.addObjectsFromArray(TopicModel.mj_objectArrayWithKeyValuesArray(obj) as [AnyObject])
            
            
            let sectionTitleArr = NSMutableArray()
            
            let sectionDataSource = NSMutableArray()
    
            var array = NSMutableArray()
            
            for model in topicModels {
                
                let topicName = (model as! TopicModel).specialContentColumn
                
                if !sectionTitleArr.containsObject(topicName) {
                    
                    sectionDataSource.addObject(array)
                    
                    sectionTitleArr.addObject(topicName)
                    
                    array = NSMutableArray()
                    
                    array.addObject(model)
                    
                }else {
                    
                    array.addObject(model)
                    
                }
                
            }
            
            sectionDataSource.removeObjectAtIndex(0)
            
            callBack(sectionTitleArr:sectionTitleArr as [AnyObject], sectionDataSource:sectionDataSource as [AnyObject], error: nil)
            
        }) { (task, error) in
            
            callBack(sectionTitleArr:nil, sectionDataSource:nil, error: error)
            
        }
    }
    
}

