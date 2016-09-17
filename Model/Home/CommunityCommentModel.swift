//
//  CommunityCommentModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation


class AdvertisementModel: NSObject {
    
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
    
    var expandId: String!
    
    var title: String!
    
    var indexpic: IndexPicModel!
    
    var childsData: NSMutableArray!
    
    var cid: String!
    
    var mainColumnId: String!
    
    var contentUrl: String!
    
    var pulishTimeStamp: String!
    
    var createTimeStamp: String!
    
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["indexpic":IndexPicModel.self,"childsData":ChildModel.self]
    }
    
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["orderId":"order_id","content_id":"contentId","siteId":"site_id","columnId":"column_id","columnName":"column_name","bundleId":"bundle_id","moduleId":"module_id","structId":"struct_id","contentFromid":"content_fromid","expandId":"expand_id","childsData":"childs_data","mainColumnId":"main_column_id","contentUrl":"content_url","pulishTimeStamp":"publish_time_stamp","createTimeStamp":"create_time_stamp"]
    }
    
}



class CommunityCommentModel: NSObject {
    
    var id: String!
    
    var siteId: String!
    
    var postId: String!
    
    var forumId: String!
    
    var source: String!
    
    var forumTitle: String!
    
    var clickNum: String!
    
    var title: String!
    
    var indexpic: PicModel!
    
    var pics: NSMutableArray!
    
    var picsNum: String!
    
    var isHaveIndexPic: String!
    
    var isHaveVideo: String!
    
    var postNum: String!
    
    var userId: String!
    
    var userName: String!
    
    var creatTime: String!
    
    var commentNum: String!
    
    var praiseNum: String!
    
    var address: String!
    
    var status: String!
    
    var createTimeFormat: String!
    
    var contentUrl: String!
    
    var userInfo: UserInfoModel!
    
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["pics":PicModel.self]
    }
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return ["siteId":"site_id","postId":"post_fid","forumId":"forum_id","forumTitle":"forum_title","clickNum":"click_num","picsNum":"pics_num","isHaveIndexPic":"is_have_indexpic","isHaveVideo":"is_have_video","postNum":"post_num","userId":"user_id","userName":"user_name","creatTime":"create_time","commentNum":"comment_num","praiseNum":"praise_num","createTimeFormat":"create_time_format","contentUrl":"content_url","userInfo":"user_info"]
    }
    
    
}


class PicModel: IndexPicModel {
    
    var contentId: String!
    
    var mtype: String!
    
    var originalId: String!

    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return ["contentId":"content_id","originalId":"original_id"]
        
    }
    
}

class UserInfoModel: NSObject {
    
    var id: String!
    
    var avatar: IndexPicModel!
    
    var userId: String!
    
    var userName: String!
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return ["userId":"user_id","userName":"user_name"]
        
    }
    
}