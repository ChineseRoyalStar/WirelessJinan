//
//  WeatherDetailViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/10.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

import MBProgressHUD

class WeatherDetailViewController: UIViewController {

    var scrollView: WeatherScrollView = {
        
        let scroll = WeatherScrollView.init(frame: CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-64))
        
        return scroll
        
        
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.titleView = UITools.navTitleLabel("济南")
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //加载scrollView
        
        self.view.addSubview(self.scrollView)
        
        scrollView.prepareForLayout()
        
        scrollView.requestForWeatherData()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
