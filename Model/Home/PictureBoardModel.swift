//
//  PictureBoardModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation


class PictureModel: NSObject {
    
    var id: String!
    
    var orderId: String!
    
    var contentId: String!
    
    var siteId: String!
    
    var columnId: String!
    
    var bundleId: String!
    
    var contentFromId: String!
    
    var title: String!
    
    var indexpic: IndexPicModel!
    
    var outlink: String!
    
    var contentUrl: String!
    
    var createTime: String!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","contentId":"content_id","siteId":"site_id","columnId":"column_id","bundleId":"bundle_id","contentFromId":"content_fromid","contentUrl":"content_url","createTime":"create_time"]
    }
    
}