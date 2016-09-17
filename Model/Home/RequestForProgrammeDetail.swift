//
//  RequestForProgrammeDetail.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension ProgrammeDetailModel {
    
    class func requestForProgrammeDetail(id:String, callBack:(programmeModels: [AnyObject]?, error:NSError?)-> Void) {
        
        /*
         
         http://pmobile.ijntv.cn/ijntv30/vod.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&access_token=1484099712dbe8b8aec56d14cad3de03&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=207566&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=207566&count=15&column_id=111&offset=0
         
         */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/vod.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"package_name":"com.hoge.android.jinan","_member_id":kMEMBERID,"count":"15","offset":"0","column_id":id]
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            
            let programmeModels = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            programmeModels.addObjectsFromArray(ProgrammeDetailModel.mj_objectArrayWithKeyValuesArray(obj) as [AnyObject])
            
            callBack(programmeModels: programmeModels as [AnyObject], error: nil)
            
            
        }) { (task, error) in
            
            callBack(programmeModels: nil, error: error)
            
        }
        
    }
    
}