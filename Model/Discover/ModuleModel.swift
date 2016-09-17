//
//  ModuleModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ModuleModel: NSObject {

    var id: String!
    
    var name: String!
    
    var modules: [ModuleCellModel]!
    
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["modules":ModuleCellModel.self]
        
    }
    
}

class ModuleCellModel: NSObject {
    
    
    var id: String!
    
    var orderId: String!
    
    var name: String!
    
    var brief: String!
    
    var sortId: String!
    
    var moluleId: String!
    
    var type: String!
    
    var host: String!
    
    var dir: String!
    
    var filename: String!
    
    var filepath: String!
    
    var url: String!
    
    var status: String!
    
    var appid: String!
    
    var userId: String!
    
    var userName: String!
    
    var createTime: String!
    
    var updateTime: String!
    
    var ip: String!
    
    var icon: IconModel!
    
    var icon1: IconModel!
    
    var icon2: IconModel!
    
    var icon3: IconModel!
    
    var icon4: IconModel!
    
    var isOpen: String!
    
    var isNewModule: String!
    
    var sortName: String!
    
    var typeName: String!
    
    var outlink: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","sortId":"sort_id","moluleId":"module_id","userId":"user_id","userName":"user_name","createTime":"create_time","updateTime":"update_time","isOpen":"is_open","isNewModule":"is_new_module","sortName":"sort_name","typeName":"type_name"]
    }
    
}

