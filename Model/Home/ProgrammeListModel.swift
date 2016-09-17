//
//  ProgrammeListModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ProgrammeListModel: NSObject {

    var id: String!
    
    var channelId: String!
    
    var scheduleId: String!
    
    var recordId: String!
    
    var startTime: String!
    
    var toff: NSNumber!
    
    var theme: String!
    
    var date: String!
    
    var weeks: String!
    
    var createTime: String!
    
    var updateTime: String!
    
    var start: String!
    
    var end: String!
    
    var zhiPlay: NSNumber!
    
    var nowPlay: NSNumber!
    
    var stime: String!
    
    var display: NSNumber!
    
    var channelName: String!
    
    var channelLogo: ChannelLogo!
    
    var m3u8: String!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["channelId":"channel_id","scheduleId":"schedule_id","recordId":"record_id","startTime":"start_time","createTime":"create_time","updateTime":"update_time","zhiPlay":"zhi_play","nowPlay":"now_play","channelName":"channel_name","channelLogo":"channel_logo"]
    }
    
}

class ChannelLogo: NSObject {
    
    var rectangle: ChildModel!
    
}


