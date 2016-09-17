//
//  ProgrammeDetailListCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

protocol ProgrammeDetailListCellDelegate:class {
    
    func changePlayingUrlTo(url:String)
    
}

class ProgrammeDetailListCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: NSMutableArray = NSMutableArray()
    
    var delegate: ProgrammeDetailListCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.congfigureTableView()
    }
    
    func congfigureTableView() {
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
        
        self.tableView.registerNib(UINib.init(nibName: "ProgrammeDetailCell", bundle: nil), forCellReuseIdentifier: "ProgrammeDetailCell")
    }
    
    
    //MARK:- UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProgrammeDetailCell", forIndexPath: indexPath) as! ProgrammeDetailCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeListModel
        
        cell.scheduledTimeLabel.text = model.stime
        
        cell.programmeLabel.text = model.theme
        
        
        if (NSTimeInterval.init(model.startTime)! <= NSDate().timeIntervalSince1970) && (NSTimeInterval.init(Int(model.startTime)!+Int(model.toff)) >= NSDate().timeIntervalSince1970){
            
            cell.programmeLabel.textColor = kSKY_BLUE
            
            cell.scheduledTimeLabel.textColor = kSKY_BLUE
            
            cell.isPlayingLabel.hidden = false
            
        }else if (NSTimeInterval.init(Int(model.startTime)!) >= NSDate().timeIntervalSince1970){
            
            cell.programmeLabel.textColor = UIColor.lightGrayColor()
            
            cell.scheduledTimeLabel.textColor = UIColor.lightGrayColor()
            
            cell.isPlayingLabel.hidden = true
            
        }else {
            
            cell.programmeLabel.textColor = UIColor.blackColor()
            
            cell.scheduledTimeLabel.textColor = UIColor.blackColor()
            
            cell.isPlayingLabel.hidden = true
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeListModel
        
        if NSTimeInterval.init(Int(model.startTime)!) <= NSDate().timeIntervalSince1970 {
            
            self.delegate.changePlayingUrlTo(model.m3u8)
            
        }
        
    }
    
}
