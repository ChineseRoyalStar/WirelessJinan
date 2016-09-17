//
//  ProgrammeDetailModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ProgrammeDetailModel: NewsModel {

    var columnInfo: ColumnInfoModel!
    
    var video: VideoModel!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","contentId":"content_id","siteId":"site_id","columnId":"column_id","columnName":"column_name","bundleId":"bundle_id","moduleId":"module_id","structId":"struct_id","contentFromid":"content_fromid","isHaveIndexpic":"is_have_indexpic","isHaveVideo":"is_have_video","clickNum":"click_num","fileName":"file_name","publishTime":"publish_time","createTime":"create_time","verifyTime":"verify_time","expendId":"expand_id","childData":"childs_data","mainColumnIid":"main_column_id","publishTimeStamp":"publish_time_stamp","createTimeStamp":"create_time_stamp","contentUrl":"content_url","columnInfo":"column_info"]
    }
    
}


class VideoModel: NSObject {
    
    var host: String!
    
    var dir: String!
    
    var filepath: String!
    
    var filename: String!
    
    var imgwidth: String!
    
    var imgheight: String!
    
    
}

class ColumnInfoModel: NSObject {
    
    var id: String!
    
    var name: String!
    
    var fid: String!
    
    var columnDir: String!
    
    var relateDir: String!
    
    var columnUrl: String!
    
    var indexpic: IndexPicModel!
    
    var icon: IconCollectionModel!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["columnDir":"column_dir","relateDir":"relate_dir","columnUrl":"column_url"]
    }
    
}