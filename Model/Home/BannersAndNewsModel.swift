//
//  AdvertisementModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation



class BannerAndNewsModel: NSObject {
    
    
    var indexpic: IndexPicModel!
    
    var childsData: NSMutableArray!
    
    var id: String!
    
    var contentId: String!
    
    var cardid: String!
    
    var moduleId: String!
    
    var moduleName: String!
    
    var title: String!
    
    var brief: String!
    
    var outlink: String!
    
    var cssid: String!
    
    var sourceFrom: String!
    
    var orderId: String!
    
    var active: String!
    
    var publishTimeStamp: String!
    
    var createTime: String!
    
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["childsData":ChildModel.self]
        
    }

    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["childsData":"childs_data","contentId":"content_id","moduleId":"module_id","moduleName":"module_name","sourceFrom":"source_from","order_id":"orderId","createTime":"create_time","publishTimeStamp":"publish_time_stamp"]
    }
    
    
    
    
}


class IndexPicModel: IconModel {
    
    var id: String!
    
    var imgwidth: String!
    
    var imgheight: String!

    
}

class ChildModel: NSObject {
    
    var title: String!
    
    var brief: String!
    
    var outlink: String!
    
    var host: String!
    
    var dir: String!
    
    var filepath: String!
    
    var filename: String!
    
    
}
