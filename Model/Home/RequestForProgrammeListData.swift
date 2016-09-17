//
//  RequestForProgrammeListData.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension ProgrammeListModel {
    
    class func requestForProgrammeListData(channelId: String, zone: String, callBack:(modelArr:[AnyObject]?,error: NSError?)->Void) {
        
        /*
        
        http://pmobile.ijntv.cn/ijntv30/program.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&channel_id=14&zone=0
        
        */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/program.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"channel_id":channelId,"zone":zone]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, response) in
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.MutableContainers)
            
            let modelArr = NSMutableArray()
            
            modelArr.addObjectsFromArray(ProgrammeListModel.mj_objectArrayWithKeyValuesArray(obj) as [AnyObject])
            
            callBack(modelArr: modelArr as [AnyObject], error: nil)
            
            }) { (task, error) in
         
            callBack(modelArr: nil, error: error)
                
        }
        
    }
    
}