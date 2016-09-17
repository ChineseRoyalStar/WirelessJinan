//
//  GossipBoardModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation


class GossipTitleModel: NSObject {
    
    var id: String!
    
    var name: String!
    
    var parents: String!
    
    var childs: String!
    
    var depath: String!
    
    var createTime: String!
    
    var updateTime: String!
    
    var ip: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["createTime":"create_time","updateTime":"update_time"]
    }
    
}

class GossipCommentModel: NSObject {
    
    var id: String!
    
    var sortId: String!
    
    var title: String!
    
    var brief: String!
    
    var createTime: String!
    
    var updateTime: String!
    
    var userId: String!
    
    var userName: String!
    
    var ip: String!
    
    var name: String!
    
    var eventTime: String!
    
    var avatar: IndexPicModel!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["sortId":"sort_id","createTime":"create_time","updateTime":"update_time","userId":"user_id","userName":"user_name","eventTime":"event_time"]
    }
    
}