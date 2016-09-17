//
//  TopicDetailViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MBProgressHUD

class TopicDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id: String!
    
    var offset = 0
    
    var sectionTitles = NSMutableArray()
    
    var dataSource = NSMutableArray()
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    lazy var headerView: UIView = {
        
        let view = UIView.init(frame: CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/2 + 40))
        
        view.backgroundColor = UIColor.whiteColor()
        
        return view
    }()
    
    lazy var bannerImageView: UIImageView = {
        
        let imageView = UIImageView.init(frame: CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/2))
        
        self.headerView.addSubview(imageView)
        
        return imageView
        
    }()
    
    lazy var abstractLabel: UILabel = {
        
        let label = UILabel.init(frame: CGRectMake(10, kSCREEN_W/2 + 10, 40, 20))
        
        label.text = "摘要"
        
        label.backgroundColor = UIColor.lightGrayColor()
        
        label.textColor = UIColor.whiteColor()
        
        return label
    }()
    
    
    lazy var abstractDetailLabel: UILabel = {
        
        let label = UILabel.init(frame: CGRectMake(60, kSCREEN_W/2 + 10, kSCREEN_W - 60 - 10, 20))
        
        label.textColor = UIColor.blackColor()
        
        label.font = UIFont.boldSystemFontOfSize(15)
        
        self.headerView.addSubview(label)
        
        return label
        
    }()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-64),style:UITableViewStyle.Grouped)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.registerNib(UINib.init(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        tableView.tableHeaderView = self.headerView
        
        self.view.addSubview(tableView)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        prepareForTopicDetailPageData()
    }
    
    
    func prepareForTopicDetailPageData() {
        
        self.progress.showAnimated(true)
        
        BannerModel.requestForBannerData(self.id) { (bannerModel, error) in
            
            if error == nil {
                
                let imgUrl = bannerModel!.indexpic.host + bannerModel!.indexpic.dir + bannerModel!.indexpic.filepath + bannerModel!.indexpic.filename
                
                self.bannerImageView.sd_setImageWithURL(NSURL.init(string: imgUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
                
                self.headerView.addSubview(self.abstractLabel)
                
                self.abstractDetailLabel.text = bannerModel?.name
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        
        TopicModel.requestForTopicData(self.id, offset: self.offset) { (sectionTitles, models, error) in
            
            if error == nil {
                
                self.sectionTitles.addObjectsFromArray(sectionTitles!)
                
                self.dataSource.addObjectsFromArray(models!)
                
                self.tableView.reloadData()
                
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
             self.progress.hideAnimated(true)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UITableViewDelegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.objectAtIndex(section).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! TopicModel
        
        let iconUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
        
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: iconUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        cell.detailLabel.text = model.title
        
        cell.updateTimeLabel.text = (model.updateTime as NSString).componentsSeparatedByString(" ").first
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as! TopicModel
        
        let wvc = WebPagePresentationViewController()
        
        wvc.contentUrl = model.contentUrl
        
        self.navigationController?.pushViewController(wvc, animated: true)
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRectMake(0, 0, kSCREEN_W, 30))
        
        view.backgroundColor = UIColor.whiteColor()
        
        let blueView = UIView.init(frame: CGRectMake(10, 0, 5, 30))
        
        blueView.backgroundColor = UIColor.blueColor()
        
        view.addSubview(blueView)
        
        let label = UILabel.init(frame: CGRectMake(30, 0, 200, 30))
        
        label.text = (self.sectionTitles.objectAtIndex(section) as! String)
        
        label.font = UIFont.boldSystemFontOfSize(18)
        
        view.addSubview(label)
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
