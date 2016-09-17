//
//  WeatherModel.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/10.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit



class CurrentWeatherModel: WeatherModel {
    
    var zwx: String!
    
    var zs: NSMutableArray!
    
    var bg_image: NSMutableArray!
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["icon":IconModel.self,"zs":ZsModel.self,"bg_image":IconModel.self]
        
    }
}

class ZsModel: NSObject {
    
    var name: String!
    
    var hint: String!
    
    var des: String!
    
}

class WeatherModel: NSObject {

    var wDate: String!
    
    var updateTime: String!
    
    var temp: String!
    
    var report: String!
    
    var fx: String!
    
    var fl: String!
    
    var formatUpdateTime: String!
    
    var formatDate: String!
    
    var icon: NSMutableArray!
    
    override class func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["icon":IconModel.self]
    }
    
    override class func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        
        return ["wDate":"w_date","updateTime":"update_time","formatUpdateTime":"format_update_time","formatDate":"format_date"]
    }
    
}


class IconModel:NSObject {
    
    var host: String!
    
    var dir: String!
    
    var filepath: String!
    
    var filename: String!
    
    
}

class PM25Model:NSObject {
    
    var aqi: String!
    
    var co: String!
    
    var co_24h: String!
    
    var no2: String!
    
    var no2_24h: String!
    
    var o3: String!
    
    var o3_24h: String!
    
    var o3_8h: String!
    
    var o3_8h_24h: String!
    
    var pm10: String!
    
    var pm10_24: String!
    
    var pm2_5: String!
    
    var pm2_5_24h: String!
    
    var primary_pollutant: String!
    
    var quality: String!
    
    var so2: String!
    
    var so2_24h: String!
    
    var time_point: String!
    
    var update_time: String!
    
    
}

class PollutantModel: NSObject {
    
    var name: String!
    
    var pollutant: String!
    
    var index: String!
    
    init(name:String, pollutant: String, index: String) {
        
        super.init()
        
        self.name = name
        
        self.pollutant = pollutant
        
        self.index = index
        
    }
    
}
