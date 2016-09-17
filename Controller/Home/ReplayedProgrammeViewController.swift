//
//  ReplayedProgrammeViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

import MBProgressHUD

class ReplayedProgrammeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var homeUrl: String!
    
    var dataSource = NSMutableArray()
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    lazy var tableView: UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 64, kSCREEN_W, kSCREEN_H - 64), style: .Plain)
        
        table.registerNib(UINib.init(nibName: "ProgrammeCell", bundle: nil), forCellReuseIdentifier: "ProgrammeCell")
        
        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.requestForReplayedProgrammeData()
            
        })
        
        table.delegate = self
        
        table.dataSource = self
        
        table.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        self.view.addSubview(table)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.requestForReplayedProgrammeData()
    }
    

    
    
    func requestForReplayedProgrammeData() {
        
        self.progress.showAnimated(true)
        
        ReplayedProgrammeModel.requestForReplayedProgrammeData(self.homeUrl) { (modelArray, error) in
            
            if error == nil {
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(modelArray!)
                
                self.tableView.reloadData()
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            self.progress.hideAnimated(true)
            
            self.tableView.mj_header.endRefreshing()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UITableView Delegate Method
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProgrammeCell", forIndexPath: indexPath) as! ProgrammeCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ReplayedProgrammeModel
        
        
        let imgUrl = (model.icon as IconCollectionModel).icon1.defaultIcon.host + (model.icon as IconCollectionModel).icon1.defaultIcon.dir + (model.icon as IconCollectionModel).icon1.defaultIcon.filepath + (model.icon as IconCollectionModel).icon1.defaultIcon.filename
        
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: imgUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        cell.channelLabel.text = model.name
        
        if (self.navigationItem.titleView?.viewWithTag(100) as! UILabel).text! == "电视点播"{
            
            cell.playIcon.image = UIImage.init(named: "live_icon_play_l")
            
        }else {
            
            cell.playIcon.image = nil
            
            if indexPath.row == 0 {
                
                cell.playIcon.image = UIImage.init(named: "live_icon_play_l")
                
            }else {
                
                cell.playIcon.image = UIImage.init(named: "live_icon_headphone_l")
                
            }
            
        }
        
        let date = NSDate.init(timeIntervalSince1970:NSTimeInterval.init( model.contentUpdateTime)!)
        
        let dateFormatter = NSDateFormatter.init()
        
        dateFormatter.dateFormat = "MM月dd日"
        
        cell.timeLabel.text = "最新更新: " + dateFormatter.stringFromDate(date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ReplayedProgrammeModel
        
        let rpvc = ReplayedPlayerViewController()
        
        rpvc.navigationItem
        
        rpvc.id = model.id
        
        self.navigationController?.pushViewController(rpvc, animated: false)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
}
