//
//  WeatherNetworkingRequest.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/11.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation

import AFNetworking

extension WeatherModel {
    
    class func requestForWeatherData(callBack:(humidity:String?,pollutants:[AnyObject]?,bgImage: IconModel?,today:CurrentWeatherModel?,weatherArr:[AnyObject]?,error:NSError?) -> Void) {
        
        
        /*
        http://pmobile.ijntv.cn/ijntv30/weather.php?appid=7&appkey=199bIMpav3kSRNtuo9GEEBpQMNPw3aaV&device_token=7bb416b46b9fe4f2c34588ad5e429bd0&_member_id=&version=1.9.6&app_version=1.9.6&app_version=1.9.6&package_name=com.hoge.android.jinan&system_version=5.0.2&phone_models=RedmiNote2&_member_id=&name=济南市
        
        */
        
        let homeUrl = "http://pmobile.ijntv.cn/ijntv30/weather.php"
        
        let para = ["appid":kAPPID,"appkey":kAPPKEY,"device_token":kDEVICE_TOKEN,"version":kVERSION,"app_version":kAPP_VERSION,"system_version":kSYSTEM_VERSION,"_member_id":"","package_name":"com.hoge.android.jinan","app_type":"android","name":"济南市"]
        
        
        
        let manager = AFHTTPSessionManager.init()
        
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        
        manager.POST(homeUrl, parameters: para, progress: nil, success: { (task, data) in
            var humidity: String?
            
            var today:CurrentWeatherModel?
            
            var pm25: PM25Model?
            
            let weatherModelArr = NSMutableArray()
            
            let pollutantModelArr = NSMutableArray()
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            let bgImg = IconModel.mj_objectWithKeyValues(((obj.objectAtIndex(1) as! NSDictionary).objectForKey("bg_image") as! NSArray).objectAtIndex(0))
            
            for i in 0...obj.count-1 {
                
                let temp = NSMutableArray()
                
                if i == 0 {
                    
                    humidity = ((obj.objectAtIndex(0) as! NSDictionary).valueForKey("realtime") as! NSDictionary).objectForKey("humidity") as? String
                    
                    today = CurrentWeatherModel.mj_objectWithKeyValues(obj.objectAtIndex(i)) as CurrentWeatherModel
                    
                    //污染物指数建模加入数组
                    pm25 = PM25Model.mj_objectWithKeyValues(((obj.objectAtIndex(i) as! NSDictionary).valueForKey("pm25_data") as! NSDictionary).objectForKey("avg")) as PM25Model
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "细粒颗物", pollutant: "PM2.5", index:pm25!.pm2_5))
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "二氧化氮", pollutant: "NO2", index: pm25!.no2))
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "一氧化碳", pollutant: "CO", index: pm25!.co))
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "可吸入颗粒物", pollutant: "PM10", index: pm25!.pm10))
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "二氧化硫", pollutant: "SO2", index: pm25!.so2))
                    
                    pollutantModelArr.addObject(PollutantModel.init(name: "臭氧1小时平均", pollutant: "O3", index: pm25!.o3))
                    
                    
                    temp.addObject(obj.objectAtIndex(i))
                    
                }else {
                    
                    temp.addObject(obj.objectAtIndex(i))
                    
                }
                
                
                let weathers = WeatherModel.mj_objectArrayWithKeyValuesArray(temp) as [AnyObject]
                
                weatherModelArr.addObjectsFromArray(weathers)
                
            }
        
                
                callBack(humidity: humidity,pollutants: pollutantModelArr as [AnyObject], bgImage: bgImg, today: today, weatherArr: weatherModelArr as [AnyObject], error: nil)
            
            
            }) { (task, error) in
                
               callBack(humidity: nil, pollutants: nil, bgImage: nil, today: nil, weatherArr: nil, error: error)
        }
        
        
    }
    
}