//
//  HomePageViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

import MJRefresh

import MBProgressHUD

class HomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    lazy var headerView: HeaderView = {
        
        let header = HeaderView()
        
        header.frame = CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/3+kBTNWIDTH*2+kINTERSPACE+40)
        
        header.delegate = self
        
        return header
        
    }()
    
    lazy var tableView:UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0,64,kSCREEN_W,kSCREEN_H-64-49), style: UITableViewStyle.Plain)
        
        table.dataSource = self
        
        table.delegate = self
        
        table.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        table.tableHeaderView?.frame = CGRectMake(0, 0, kSCREEN_W, 100)
        
        table.tableHeaderView = self.headerView
        
        table.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.prepareForHomePageData()
            
        })
        
        table.registerNib(UINib.init(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        table.registerNib(UINib.init(nibName:"BannerCell",bundle: nil), forCellReuseIdentifier: "BannerCell")
        
        self.view.addSubview(table)
        
        return table
        
    }()
    
    lazy var progressHud: MBProgressHUD = {
        
        let progress = MBProgressHUD.init()
        
        progress.center = self.view.center
        
        progress.detailsLabel.text = "正在载入..."
        
        self.view.addSubview(progress)
        
        return progress
        
    }()
    
    var adsUrlArr = [String]()
    
    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.createTitleView()
        
        self.prepareForHomePageData()
        
        self.prepareForWeatherBtn()
        
    }
    
    func createTitleView() -> Void {

        //Navigation Logo
        let titleView = UIView()
        
        titleView.frame = CGRectMake(0, 0, 150, 44)
        
        let logo1 = UIImageView.init(frame: CGRectMake(0, 5, 30, 30))
        
        logo1.image = UIImage.init(named: "ic_launcher")
        
        let logo2 = UIImageView.init(frame: CGRectMake(40, 5, 120, 30))
        
        logo2.image = UIImage.init(named: "logo")
        
        titleView.addSubview(logo1)
        
        titleView.addSubview(logo2)
        
        self.navigationItem.titleView = titleView
        
    }
    
    func prepareForHomePageData() {
        
        self.progressHud.showAnimated(true)
        
        BannerAndNewsModel.requestForAdvertisementAndNewsData { (ads, news, error) in
            
            if error == nil {
                
                self.headerView.createButtons()
                
                self.headerView.adView.imageURLArray.removeAll()
                
                //Loading the advertisement Bar
                for ad in ads! {
                    
                    let urlStr = (ad as! ChildModel).host + (ad as! ChildModel).dir + (ad as! ChildModel).filepath + (ad as! ChildModel).filename
                    
                    self.headerView.adView.imageURLArray.append(urlStr)
                    
                }
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(news!)
                
                self.tableView.reloadData()
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            self.progressHud.hideAnimated(true)
            
            self.tableView.mj_header.endRefreshing()
        }
        
    }
    
    func prepareForWeatherBtn() -> Void {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image:UIImage.init(named: "weatherIcon")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.pushToWeatherDetail))
    }
    
    func pushToWeatherDetail() {
        
        let wvc = WeatherDetailViewController()
        
        wvc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(wvc, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- TableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.dataSource.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource[section].count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BannerAndNewsModel
        
        if model.indexpic == nil {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! BannerCell
            
            let url = ((model.childsData[0]) as! ChildModel).host + ((model.childsData[0]) as! ChildModel).dir + ((model.childsData[0]) as! ChildModel).filepath + ((model.childsData[0]) as! ChildModel).filename
            
            cell.bannerImage.sd_setImageWithURL(NSURL.init(string: url),placeholderImage: UIImage.init(named: "placeholder.jpg"))
            
            return cell
            
        }else {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
            
            let imgUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
            
            cell.iconImage.sd_setImageWithURL(NSURL.init(string: imgUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
            
            cell.detailLabel.attributedText = UITools.attributedStringWithLineSpace(model.title, sizeOfFont:16, lineSpace: 5)
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BannerAndNewsModel
        
        if model.indexpic == nil {
            
            return 130
            
        }else {
            
            return 90
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BannerAndNewsModel
        
        
        if model.indexpic != nil {
            
            let newsVC = NewsDetailViewController()
            
            newsVC.contentId = model.contentId
            
            newsVC.navigationItem.titleView = UITools.navTitleLabel(model.moduleName)
            
            newsVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(newsVC, animated: true)
            
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! BannerAndNewsModel
        
        if model.indexpic == nil {
            
            return false
        }
        
        return true
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0,0,kSCREEN_W,6))
        
        view.backgroundColor = UIColor.init(red: 0.667, green: 0.667, blue: 0.667, alpha: 0.3)
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
}
