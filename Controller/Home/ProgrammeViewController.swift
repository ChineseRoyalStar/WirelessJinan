//
//  ProgrammeViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

import MBProgressHUD

class ProgrammeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
            
            self.requestForProgrammeData()
            
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
        
        //self.view.addSubview(tableView)
        
        requestForProgrammeData()
        
    }

    
    func requestForProgrammeData() {
        
        self.progress.showAnimated(true)
        
        ProgrammeModel.requestForProgrammeData(self.homeUrl) {(modelArray, error) in
            
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
    
    
    //MARK:-  UITabelView Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ProgrammeCell", forIndexPath: indexPath) as! ProgrammeCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeModel
        
        let iconUrl = model.logo.square.host + model.logo.square.dir + model.logo.square.filepath + model.logo.square.filename
        
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: iconUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        cell.channelLabel.text = model.name
        
        cell.channelLabel.font = UIFont.boldSystemFontOfSize(17)
        
        cell.timeLabel.text = model.nextProgram.startTime
        
        cell.programmeNameLabel.text = model.nextProgram.program
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeModel
        
   //     let iconUrl = model.logo.square.host + model.logo.square.dir + model.logo.square.filepath + model.logo.square.filename
        
        let ppvc = ProgrammePlayerViewController()
        
        ppvc.url = model.m3u8
        
        ppvc.channelId = model.id
        
        self.navigationController?.pushViewController(ppvc, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
}
