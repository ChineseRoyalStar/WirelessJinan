//
//  RequestDataForModules.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension ModuleModel {
    
    
    class func requestDataForModules(callBack:(ModulesArr:[AnyObject]?,error:NSError?) -> Void){
        
        //http://pmobile.ijntv.cn/ijntv30/mobile_module.php?http://pmobile.ijntv.cn/ijntv30/mobile_module.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=3ce178e512d4e9b8666a5b0f23dd1f54&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&adimg=http://pimg.ijntv.cn/material/adv/img/2016/08/6aa08b447da29788e500f86cc5c996bc.jpg&version_code=20160603&debug=0&version=1.9.6
        
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/mobile_module.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"access_token":"","device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"207566","package_name":"com.hoge.android.jinan","version_code":"20160603"]
        
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, response) in
            
            
            let modulesArr = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            modulesArr.addObjectsFromArray(ModuleModel.mj_objectArrayWithKeyValuesArray(obj.objectForKey("module") as! NSArray) as [AnyObject])
            
            
            callBack(ModulesArr: modulesArr as [AnyObject], error: nil)
            
            
        }) { (task, error) in
            
            callBack(ModulesArr: nil, error: error)
            
        }
        
        
        
        
        
        
        
    }
    
    
    
}