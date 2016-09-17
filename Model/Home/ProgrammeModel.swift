//
//  ProgrammeModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

class ProgrammeModel: NSObject {

    var id: String!
    
    var name: String!
    
    var logo: LogoModel!
    
    var m3u8: String!
    
    var snap: IconModel!
    
    var curProgram: ProgramModel!
    
    var saveTime: String!
    
    var nextProgram: ProgramModel!
    
    var audioOnly: String!
    
    var aspect: String!
    
    var channelStream: [StreamModel]!
    
    var recordStream: [StreamModel]!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["curProgram":"cur_program","saveTime":"save_time","nextProgram":"next_program","audioOnly":"audio_only","channelStream":"channel_stream","recordStream":"record_stream"]
    }
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["channelStream":StreamModel.self,"recordStream":StreamModel.self]
        
    }

    
}

class LogoModel: NSObject {
    
    var rectangle: IconModel!
    
    var square: IconModel!
    
}




class ProgramModel: NSObject {
    
    var startTime: String!
    
    var program: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["startTime":"start_time"]
    }
    
}

class StreamModel: NSObject {
    
    var url: String!
    
    var m3u8: String!
    
    var bitrate: String!
    
    var liveUrl: String!
    
    var liveM3U8: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["liveUrl":"live_url","liveM3U8":"live_m3u8"]
    }
    
    
}


//Replayed Programme Model


class ReplayedProgrammeModel: NSObject {
    
    var siteName: String!
    
    var subWeburl: String!
    
    var weburl: String!
    
    var id: String!
    
    var orderId: String!
    
    var sortId: String!
    
    var siteId: String!
    
    var name: String!
    
    var fid: String!
    
    var parents: String!
    
    var childs: String!
    
    var isLast: String!
    
    var createTime: String!
    
    var ip: String!
    
    var userId: String!
    
    var userName: String!
    
    var isOutlink: String!
    
    var columnUrl: String!
    
    var childomain: String!
    
    var colindex: String!
    
    var folderformat: String!
    
    var fileformat: String!
    
    var suffix: String!
    
    var status: String!
    
    var isbuilt: String!
    
    var maketype: String!
    
    var columnFile: String!
    
    var isAudio: String!
    
    var contentUpdateTime: String!
    
    var updateTime: String!
    
    var contentNum: String!
    
    var indexpic: IndexPicModel!
    
    var columnDomain: String!
    
    var icon: IconCollectionModel!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return ["siteName":"site_name","subWeburl":"sub_weburl","order_id":"orderId","sortId":"sort_id","siteId":"site_id","isLast":"is_last","createTime":"create_time","userId":"user_id","userName":"user_name","isOutlink":"is_outlink","columnUrl":"column_url","columnFile":"column_file","isAudio":"is_audio","contentUpdateTime":"content_update_time","updateTime":"update_time","contentNum":"content_num","columnDomain":"column_domain"]
        
    }
    
}

class IconCollectionModel: NSObject {
    
    var icon1: IconArrayModel!
    
    var icon2: IconArrayModel!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["icon1":"icon_1","icon2":"icon_2"]
    }
    
    
}


class IconArrayModel: NSObject {
    
    var defaultIcon: IndexPicModel!
    
    var activation: IndexPicModel!
    
    var noActivation: IndexPicModel!
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["defaultIcon":"default","noActivation":"no_activation"]
    }
    
}


