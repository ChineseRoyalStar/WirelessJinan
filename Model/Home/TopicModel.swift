//
//  TopicModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

class TopicModel: AdvertisementModel {
    
    
    var specialId: String!
    
    var columns: String!
    
    var pudId: String!
    
    var userId: String!
    
    var columnUrl: String!
    
    var updateTime: String!
    
    var specialContentColumn: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","content_id":"contentId","siteId":"site_id","columnId":"column_id","columnName":"column_name","bundleId":"bundle_id","moduleId":"module_id","structId":"struct_id","contentFromid":"content_fromid","expandId":"expand_id","childsData":"childs_data","mainColumnId":"main_column_id","contentUrl":"content_url","pulishTimeStamp":"publish_time_stamp","createTimeStamp":"create_time_stamp","specialId":"special_id","pudId":"pud_id","columnUrl":"column_url","specialContentColumn":"special_content_column","updateTime":"update_time"]
    }
    
}

class BannerModel: NSObject {
    
    var id: String!
    
    var name: String!
    
    var tcolor: String!
    
    var isbold: String!
    
    var isitalic: String!
    
    var link: String!
    
    var brief: String!
    
    var pic: IndexPicModel!
    
    var topPic: IndexPicModel!
    
    var orderId: String!
    
    var columnId: String!
    
    var indexpic: IndexPicModel!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["topPic":"top_pic","orderId":"order_id","columnId":"column_id"]
    }
    
}