//
//  VRChannelModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit


class VRChannelModel: GossipTitleModel {


    
}

class VRListModel: PictureModel {
    
    var publishTimeStamp: String!
    
    var createTimeStamp: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","contentId":"content_id","siteId":"site_id","columnId":"column_id","bundleId":"bundle_id","contentFromId":"content_fromid","contentUrl":"content_url","createTime":"create_time","publishTimeStamp":"publish_time_stamp","createTimeStamp":"create_time_stamp"]
    }
    
    
}