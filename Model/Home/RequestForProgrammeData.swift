//
//  RequestForProgrammeData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension ProgrammeModel {
    
    
    class func requestForProgrammeData(homeUrl:String,callBack:(modelArray:[AnyObject]?,error: NSError?)->Void) {
        
        
        /*
         
         http://pmobile.ijntv.cn/ijntv30/channel.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=3ce178e512d4e9b8666a5b0f23dd1f54&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=20&offset=0
         
         */
        
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"offset":"0"]
        
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            
            let modelsArr = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            modelsArr.addObjectsFromArray(ProgrammeModel.mj_objectArrayWithKeyValuesArray(obj) as [AnyObject])
            
            
            callBack(modelArray: modelsArr as [AnyObject], error: nil)
            
            
        }) { (task, error) in
            
            callBack(modelArray: nil, error: error)
            
        }
    }
}