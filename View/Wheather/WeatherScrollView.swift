//
//  WeatherScrollView.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/10.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

import MBProgressHUD

class WeatherScrollView: UIScrollView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    var bgImageView: UIImageView! //背景
    
    var titleLabel: UILabel!
    
    var pmLabel: UILabel!
    
    var attachmentLabel: UILabel!
    
    var currentWeatherImage: UIImageView!
    
    var weekdayLabel: UILabel!
    
    var temperatureLabel: UILabel!
    
    var weatherLabel: UILabel!
    
    var windLabel: UILabel!
    
    var humidityLabel: UILabel!
    
    var ultravioletLabel: UILabel!
    
    var weeklyWeatherCollectionView: UICollectionView!
    
    var updateTimeLabel: UILabel!
    
    var indexLabel: UILabel!
    
    var indexCollectionView: UICollectionView!
    
    var airQualityLabel: UILabel!
    
    var pollutantCollectionView: UICollectionView!
    
    
    //weeklyWeatherCollectionView DataSource
    
    var dataSourceForWeather = NSMutableArray()
    
    //indexCollectionView DataSoucre
    
    var dataSourceForIndex = NSMutableArray()
    
    //pollutantCollectionView DataSoucre
    
    var dataSourceForPollutants = NSMutableArray()
    
    lazy var progress: MBProgressHUD = {
        
        let window = UIApplication.sharedApplication().keyWindow
        
        let progress = MBProgressHUD.init()
        
        progress.frame = CGRectMake(0, 0, 200, 200)
        
        progress.detailsLabel.text = "加载天气..."
        
        progress.center = (UIApplication.sharedApplication().keyWindow?.center)!
        
        UIApplication.sharedApplication().keyWindow?.addSubview(progress)
        
        return progress
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.scrollEnabled = true
        
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            
            self.requestForWeatherData()
            
            self.weeklyWeatherCollectionView.reloadData()
            
        })
        
        self.contentSize = CGSizeMake(kSCREEN_W, kSCREEN_H * 2 + 80)
        
        
    }
    
    func prepareForLayout() -> Void {
        
        bgImageView = UIImageView.init()
        
        self.addSubview(bgImageView)
        
        bgImageView.snp_makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(kSCREEN_W)
            
            make.height.equalTo(kSCREEN_H-64)
            
            make.top.equalTo(self.superview!).offset(64)
        }
        
        
        //资讯标签
        titleLabel = UILabel()
        
        self.addSubview(titleLabel)
        
        titleLabel.textColor = UIColor.whiteColor()
        
        titleLabel.font = UIFont.boldSystemFontOfSize(30)
        
        titleLabel.textAlignment = NSTextAlignment.Center
        
        titleLabel.snp_makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(34)
            
            make.centerX.equalToSuperview()
            
            make.width.height.equalTo(kLARGEICON)
            
        }
        
        
        pmLabel = UILabel()
        
        //  titleLabel.hidden = true
        
        //PM2.5标签
        
        self.addSubview(pmLabel)
        
        
        pmLabel.textColor = UIColor.whiteColor()
        
        pmLabel.font = UIFont.systemFontOfSize(23)
        
        pmLabel.textAlignment = NSTextAlignment.Center
        
        pmLabel.snp_makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(34)
            
            make.right.equalToSuperview().offset(kSCREEN_W-30)
            
            make.width.height.equalTo(kLARGEICON)
            
        }
        
        //pmLabel.hidden = true
        
        attachmentLabel = UILabel()
        
        self.addSubview(attachmentLabel)
        
        attachmentLabel.textColor = UIColor.whiteColor()
        
        attachmentLabel.font = UIFont.systemFontOfSize(12)
        
        attachmentLabel.textAlignment = NSTextAlignment.Center
        
        attachmentLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(pmLabel).offset(15)
            
            make.centerX.equalTo(pmLabel)
            
            make.width.equalTo(pmLabel)
            
            make.height.equalTo(15)
            
            
        }
        
        
        //天气图
        
        currentWeatherImage = UIImageView()
        
        self.addSubview(currentWeatherImage)
        
        currentWeatherImage.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(kLARGEICON)
            
            make.top.equalTo(self.pmLabel.snp_bottom).offset(30)
            
            make.left.equalTo(self.snp_right).offset(30)
            
        }
        
        //星期标签
        
        weekdayLabel = UILabel.init()
        
        self.addSubview(weekdayLabel)
        
        weekdayLabel.font = UIFont.systemFontOfSize(18)
        
        weekdayLabel.textColor = UIColor.whiteColor()
        
        weekdayLabel.textAlignment = .Right
        
        weekdayLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.pmLabel.snp_bottom).offset(30)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        //温度标签
        
        temperatureLabel = UILabel.init()
        
        self.addSubview(temperatureLabel)
        
        temperatureLabel.font = UIFont.boldSystemFontOfSize(23)
        
        temperatureLabel.textColor = UIColor.whiteColor()
        
        temperatureLabel.textAlignment = .Right
        
        temperatureLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.weekdayLabel.snp_bottom).offset(13)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        //天气标签
        
        weatherLabel = UILabel.init()
        
        self.addSubview(weatherLabel)
        
        weatherLabel.font = UIFont.systemFontOfSize(18)
        
        weatherLabel.textColor = UIColor.whiteColor()
        
        weatherLabel.textAlignment = .Right
        
        weatherLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.temperatureLabel.snp_bottom).offset(13)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        
        //风强标签
        
        windLabel = UILabel()
        
        self.addSubview(windLabel)
        
        windLabel.font = UIFont.systemFontOfSize(18)
        
        windLabel.textColor = UIColor.whiteColor()
        
        windLabel.textAlignment = .Right
        
        windLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.weatherLabel.snp_bottom).offset(13)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        //湿度标签
        
        humidityLabel = UILabel()
        
        self.addSubview(humidityLabel)
        
        humidityLabel.font = UIFont.systemFontOfSize(18)
        
        humidityLabel.textColor = UIColor.whiteColor()
        
        humidityLabel.textAlignment = .Right
        
        humidityLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.windLabel.snp_bottom).offset(13)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        
        //紫外线强度标签
        
        ultravioletLabel = UILabel()
        
        self.addSubview(ultravioletLabel)
        
        ultravioletLabel.textColor = UIColor.whiteColor()
        
        ultravioletLabel.font =  UIFont.systemFontOfSize(18)
        
        ultravioletLabel.textAlignment = .Right
        
        ultravioletLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.humidityLabel.snp_bottom).offset(13)
            
            make.right.equalTo(self.pmLabel)
            
            make.height.equalTo(kLABELHEIGHT)
            
        }
        
        //一周天气
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        layout.itemSize = CGSizeMake(kSCREEN_W/3-10, 150)
        
        weeklyWeatherCollectionView = UICollectionView.init(frame: CGRectMake(0, 0, kSCREEN_W,150), collectionViewLayout: layout)
        
        self.addSubview(weeklyWeatherCollectionView)
        
        weeklyWeatherCollectionView.backgroundColor = UIColor.clearColor()
        
        weeklyWeatherCollectionView.showsHorizontalScrollIndicator = false
        
        weeklyWeatherCollectionView.registerNib(UINib.init(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCell")
        
        weeklyWeatherCollectionView.delegate = self
        
        weeklyWeatherCollectionView.dataSource = self
        
        weeklyWeatherCollectionView.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.ultravioletLabel.snp_bottom).offset(50)
            
            make.centerX.equalTo(self)
            
            make.width.equalTo(kSCREEN_W)
            
            make.height.equalTo(150)
        }
        
        //更新时间
        
        updateTimeLabel = UILabel()
        
        self.addSubview(updateTimeLabel)
        
        updateTimeLabel.textColor = UIColor.whiteColor()
        
        updateTimeLabel.font = UIFont.systemFontOfSize(14)
        
        updateTimeLabel.textAlignment = NSTextAlignment.Center
        
        updateTimeLabel.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(titleLabel)
            
            make.top.equalTo(weeklyWeatherCollectionView.snp_bottom).offset(20)
            
            make.width.equalTo(kSCREEN_W)
            
        }
        
        //今日指数标题
        indexLabel = UILabel()
        
        self.addSubview(indexLabel)
        
        indexLabel.font = UIFont.systemFontOfSize(18)
        
        indexLabel.text = "今日指数"
        
        indexLabel.textColor = UIColor.whiteColor()
        
        indexLabel.textAlignment = NSTextAlignment.Left
        
        indexLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(self.weeklyWeatherCollectionView).offset(20)
            
            make.top.equalTo(self.updateTimeLabel).offset(50)
            
            make.width.equalTo(kSCREEN_W/2)
            
        }
        
        
        //今日指数
        
        let paddingSpace:CGFloat = 10
        
        let indexLayout = UICollectionViewFlowLayout()
        
        indexLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        indexLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let indexItemWidth = (kSCREEN_W - paddingSpace - paddingSpace - paddingSpace*2)/2
        
        let indexItemHeight = indexItemWidth * 0.618
        
        indexLayout.itemSize = CGSizeMake(indexItemWidth, indexItemHeight)
        
        indexCollectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: indexLayout)
        
        self.addSubview(indexCollectionView)
        
        indexCollectionView.backgroundColor = UIColor.clearColor()
        
        indexCollectionView.bounces = false
        
        indexCollectionView.dataSource = self
        
        indexCollectionView.scrollEnabled = false
        
        indexCollectionView.delegate = self
        
        indexCollectionView.showsVerticalScrollIndicator = false
        
        indexCollectionView.registerNib(UINib.init(nibName: "IndexCell", bundle: nil), forCellWithReuseIdentifier: "IndexCell")
        
        indexCollectionView.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.indexLabel).offset(30)
            
            make.centerX.equalTo(self.weeklyWeatherCollectionView)
            
            make.width.equalTo(kSCREEN_W)
            
            make.height.equalTo(indexItemHeight * 3 + paddingSpace*2)
            
            
        }
        
        //空气质量指数标题
        airQualityLabel = UILabel()
        
        self.addSubview(airQualityLabel)
        
        airQualityLabel.font = UIFont.systemFontOfSize(18)
        
        airQualityLabel.text = "空气质量指数"
        
        airQualityLabel.textColor = UIColor.whiteColor()
        
        airQualityLabel.textAlignment = NSTextAlignment.Left
        
        airQualityLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(self.indexCollectionView).offset(20)
            
            make.top.equalTo(self.indexCollectionView.snp_bottom).offset(50)
            
            make.width.equalTo(kSCREEN_W/2)
            
        }
        
        
        //空气质量指数
        
        let airQualityLayout = UICollectionViewFlowLayout()
        
        airQualityLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        airQualityLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        let airItemWidth:CGFloat = (kSCREEN_W - paddingSpace*2 - paddingSpace - paddingSpace*2 - paddingSpace*2)/3
        
        let airItemHeight:CGFloat = 80
        
        airQualityLayout.itemSize = CGSizeMake(airItemWidth, airItemHeight)
        
        pollutantCollectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: airQualityLayout)
        
        self.addSubview(pollutantCollectionView)
        
        pollutantCollectionView.delegate = self
        
        pollutantCollectionView.dataSource = self
        
        pollutantCollectionView.bounces = false
        
        pollutantCollectionView.backgroundColor = UIColor.clearColor()
        
        pollutantCollectionView.scrollEnabled = false
        
        pollutantCollectionView.showsVerticalScrollIndicator = false
        
        pollutantCollectionView.registerNib(UINib.init(nibName: "PollutantCell", bundle: nil), forCellWithReuseIdentifier: "PollutantCell")
        
        pollutantCollectionView.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.airQualityLabel.snp_bottom).offset(30)
            
            make.centerX.equalTo(self.weeklyWeatherCollectionView)
            
            make.width.equalTo(kSCREEN_W)
            
            make.height.equalTo(airItemHeight * 2 + paddingSpace * 3)
            
            
        }
        
    }
    
    
    //MARK:- 请求天气界面网络数据
    func requestForWeatherData() -> Void {
        
        self.progress.showAnimated(true)
        
        WeatherModel.requestForWeatherData() { (humidity, pollutants, bgImage, today, weatherArr, error) in
            
            if error == nil {
                
                self.titleLabel.text = "资讯"
                
                self.titleLabel.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
                
                self.attachmentLabel.text = "PM2.5"
                
                let bgImageUrl = bgImage!.host + bgImage!.dir + bgImage!.filepath + bgImage!.filename
                
                self.bgImageView.sd_setImageWithURL(NSURL.init(string:bgImageUrl))
                
                
                let weatherImage = today?.icon.objectAtIndex(0) as! IconModel
                
                let weatherImageUrl = weatherImage.host + weatherImage.dir + weatherImage.filepath + weatherImage.filename
                
                self.currentWeatherImage.sd_setImageWithURL(NSURL.init(string:weatherImageUrl))
                
                self.pmLabel.text = ((pollutants! as NSArray).objectAtIndex(0) as! PollutantModel).index
                
                self.pmLabel.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
                
                let date = NSDate.init()
                
                self.weekdayLabel.text = "今天  " + kWEEKDAYS[date.dayOfWeek()]
                
                
                self.temperatureLabel.text = today?.temp
                
                self.weatherLabel.text = today?.report
                
                self.windLabel.text = today?.fx
                
                self.humidityLabel.text = "湿度  " + humidity!
                
                self.ultravioletLabel.text = "紫外线  " + (today?.zwx)!
                
                
                //天气视图数据源
                self.dataSourceForWeather.removeAllObjects()
                
                self.dataSourceForWeather.addObjectsFromArray(weatherArr!)
                
                self.weeklyWeatherCollectionView.reloadData()
                
                self.updateTimeLabel.text = "更新于  " + (today?.formatUpdateTime)!
                
                //指数视图数据源
                self.dataSourceForIndex.removeAllObjects()
                
                self.dataSourceForIndex.addObjectsFromArray((today?.zs)! as [AnyObject])
                
                self.indexCollectionView.reloadData()
                
                //空气指数数据源
                
                self.dataSourceForPollutants.removeAllObjects()
                
                self.dataSourceForPollutants.addObjectsFromArray(pollutants! as [AnyObject])
                
                self.pollutantCollectionView.reloadData()
                
                
            }else {
                
                
            }
            
            self.progress.hideAnimated(true)
            
            self.mj_header.endRefreshing()
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- UICOLLECTIONVIEW DELEGATE METHODS
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == weeklyWeatherCollectionView {
            
            return self.dataSourceForWeather.count
            
        }else if collectionView == indexCollectionView{
            
            return self.dataSourceForIndex.count
            
        }else {
            
            return self.dataSourceForPollutants.count
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == weeklyWeatherCollectionView {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WeatherCell", forIndexPath: indexPath) as! WeatherCell
            
            let model = self.dataSourceForWeather[indexPath.row] as! WeatherModel
            
            
            let date = NSDate()
            
            cell.weekDayLabel.text = kWEEKDAYS[(date.dayOfWeek() + indexPath.row)%7]
            
            cell.temperatureLabel.text = model.temp
            
            cell.weatherLabel.text = model.report
            
            cell.windLabel.text = model.fx
            
            let iconModel = model.icon.objectAtIndex(0) as! IconModel
            
            let weatherImageUrl = iconModel.host + iconModel.dir + iconModel.filepath + iconModel.filename
            
            cell.weatherImageView.sd_setImageWithURL(NSURL.init(string: weatherImageUrl))
            
            return cell
            
        }else if collectionView == indexCollectionView{
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IndexCell", forIndexPath: indexPath) as! IndexCell
            
            let model = self.dataSourceForIndex[indexPath.row] as! ZsModel
            
            cell.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
            
            cell.iconImageView.image = UIImage.init(named: kINDEX[indexPath.row])
            
            cell.itemLabel.text = model.name
            
            cell.adviceLabel.text = model.hint
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PollutantCell", forIndexPath: indexPath) as! PollutantCell
            
            let model = self.dataSourceForPollutants[indexPath.row] as! PollutantModel
            
            cell.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
            
            cell.indexLabel.text = model.index
            
            cell.pollutantLabel.text = model.pollutant
            
            cell.nameLabel.text = model.name
            
            return cell
        }
        
    }
    
}


extension NSDate {
    
    
    func dayOfWeek() -> Int{
        
        let interval = self.timeIntervalSince1970
        
        let days = Int(interval/86400)
        
        return (days - 3) % 7
        
    }
    
}
