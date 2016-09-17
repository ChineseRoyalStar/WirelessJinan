//
//  NewsModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation


class NewsModel:NSObject {
    
    var id: String!
    
    var orderId: String!
    
    var contentId: String!
    
    var siteId: String!
    
    var columnId: String!
    
    var columnName: String!
    
    var bundleId: String!
    
    var moduleId: String!
    
    var structId: String!
    
    var contentFromid: String!
    
    var weight: String!
    
    var isHaveIndexpic: String!
    
    var isHaveVideo: String!
    
    var clickNum: String!
    
    var fileName: String!
    
    var publishTime: String!
    
    var createTime: String!
    
    var verifyTime: String!
    
    var expendId: String!
    
    var title: String!
    
    var breif: String!
    
    var indexpic: IndexPicModel!
    
    var source: String!
    
    var childData: [ChildModel]!
    
    var cid: String!
    
    var mainColumnIid: String!
    
    var publishTimeStamp: String!
    
    var createTimeStamp: String!
    
    var contentUrl: String!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","contentId":"content_id","siteId":"site_id","columnId":"column_id","columnName":"column_name","bundleId":"bundle_id","moduleId":"module_id","structId":"struct_id","contentFromid":"content_fromid","isHaveIndexpic":"is_have_indexpic","isHaveVideo":"is_have_video","clickNum":"click_num","fileName":"file_name","publishTime":"publish_time","createTime":"create_time","verifyTime":"verify_time","expendId":"expand_id","childData":"childs_data","mainColumnIid":"main_column_id","publishTimeStamp":"publish_time_stamp","createTimeStamp":"create_time_stamp","contentUrl":"content_url"]
    }
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["childsData":ChildModel.self]
        
    }
    
}