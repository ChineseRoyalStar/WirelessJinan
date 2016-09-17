//
//  GossipCommentListCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

class GossipCommentListCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var id: String?
    
    var currentOffset: Int = 0
    
    var dataSource = NSMutableArray()
    
    weak var delegate: GossipViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.currentOffset = 0
            
            self.requestForGossipCommentData(self.id!,offset: 0,state: OperationState.PullDown)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.currentOffset += 20
            
            self.requestForGossipCommentData(self.id!, offset: self.currentOffset, state: OperationState.PullUp)
            
        })
        
        self.tableView.mj_footer.automaticallyHidden = true
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.registerNib(UINib.init(nibName: "GossipCommentCell", bundle: nil), forCellReuseIdentifier: "GossipCommentCell")
        
    }
    
    
    func requestForGossipCommentData(id: String, offset: Int, state: OperationState) -> Void {
        
        GossipCommentModel.requestForGossipCommentData(self.id!, offset: self.currentOffset) { (commentModels, error) in
            
            if error == nil {
                
                if state == OperationState.PullDown {
                    
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    
                    self.dataSource.removeAllObjects()
                    
                    self.dataSource.addObjectsFromArray(commentModels!)
                    
                    self.tableView.reloadData()
                    
                    
                }else {
                    
                    self.dataSource.addObjectsFromArray(commentModels!)
                    
                    self.tableView.reloadData()
                    
                }
                
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.delegate!.presentViewController(alert, animated: true, completion: nil)
                
                
            }
            
            self.tableView.mj_header.endRefreshing()
            
            self.tableView.mj_footer.endRefreshing()
            
        }
        
    }
    
    
    //MARK:- UITableView Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("GossipCommentCell", forIndexPath: indexPath) as! GossipCommentCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! GossipCommentModel
        
        cell.portraitImage.image = nil
        
        if model.avatar != nil {
            
            cell.portraitImage.layer.cornerRadius = cell.portraitImage.frame.size.height/2
            
            cell.portraitImage.layer.masksToBounds = true
            
            let imgUrl = model.avatar.host + model.avatar.dir + model.avatar.filepath + model.avatar.filename
            
            cell.portraitImage.sd_setImageWithURL(NSURL.init(string: imgUrl))
            
        }
        
        cell.userNameLabel.text = model.userName
        
        cell.commentLabel.text = model.title
        
        
        cell.markLabel.text = model.name
        
        cell.markLabel.layer.borderWidth = 0.8
        
        cell.markLabel.layer.cornerRadius = cell.markLabel.frame.size.height/2
        
        cell.markLabel.layer.borderColor = UIColor.blackColor().CGColor
        
        cell.markLabel.layer.masksToBounds = true
        

        let dateFormatter = NSDateFormatter.init()
        
        let createDate = NSDate.init(timeIntervalSince1970: NSTimeInterval.init(model.eventTime)!)
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let createDateStr = (createDate.description as NSString).componentsSeparatedByString(" ").first!
        
        let currentDateStr = (NSDate.init().description as NSString).componentsSeparatedByString(" ").first!

        
        if createDateStr == currentDateStr {
            
            let timeFormatter = NSDateFormatter.init()
            
            timeFormatter.dateFormat = "hh:mm"
            
            let timeStr = (model.createTime as NSString).componentsSeparatedByString(" ").last!
            
            cell.timeLabel.text = "今天" + timeStr
            
            
        }else {
            
            let presentDateFormatter = NSDateFormatter.init()
            
            presentDateFormatter.dateFormat = "MM-dd hh:mm"
            
            cell.timeLabel.text = presentDateFormatter.stringFromDate(createDate)
            
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    
}
