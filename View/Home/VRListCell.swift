//
//  VRListCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

class VRListCell: UICollectionViewCell, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var vrModel: VRChannelModel?
    
    var currentOffset: Int = 0
    
    var dataSource = NSMutableArray()
    
    weak var delegate: VRChannelViewController?
    
    lazy var adsView: XTADScrollView = {
        
        let ads = XTADScrollView.init(frame: CGRectMake(0, 0, kSCREEN_W, kSCREEN_W*2/3))
        
        ads.infiniteLoop = false
        
        ads.needPageControl = true
        
        ads.placeHolderImageName = "placeholder.jpg"
        
        ads.imageURLArray = [AnyObject]()
        
        self.tableView.tableHeaderView = ads
        
        return ads
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.allowsSelection = true
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.currentOffset = 0
            
            self.requestForVRNewsData(self.vrModel!,offset: 0,state: OperationState.PullDown)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.currentOffset += 20
            
            self.requestForVRNewsData(self.vrModel!, offset: self.currentOffset, state: OperationState.PullUp)
            
        })
        
        self.tableView.mj_footer.automaticallyHidden = true
        
        tableView.registerNib(UINib.init(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
    }
    
    
    func requestForVRNewsData(model: VRChannelModel, offset: Int, state: OperationState) -> Void {
        
        VRListModel.requestForNewsData(model, offset: offset) { (newsArr, title, error) in
            
            if error == nil {
                
                if state == OperationState.PullDown {
                    
                    self.dataSource.removeAllObjects()
                    
                    self.dataSource.addObjectsFromArray(newsArr!)
                    
                    self.tableView.reloadData()
                    
                    
                }else {
                    
                    self.dataSource.addObjectsFromArray(newsArr!)
                    
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! VRListModel
        
        let imgUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
        
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: imgUrl), placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        cell.detailLabel.attributedText = UITools.attributedStringWithLineSpace(model.title, sizeOfFont: 16, lineSpace: 5)

        
        let dateFormatter = NSDateFormatter.init()
        
        let createDate = NSDate.init(timeIntervalSince1970: NSTimeInterval.init(model.createTimeStamp)!)
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let createDateStr = (createDate.description as NSString).componentsSeparatedByString(" ").first!
        
        let currentDateStr = (NSDate.init().description as NSString).componentsSeparatedByString(" ").first!
        
        
        if createDateStr == currentDateStr {
            
            let timeFormatter = NSDateFormatter.init()
            
            timeFormatter.dateFormat = "hh:mm"
            
            let timeStr = (model.createTime as NSString).componentsSeparatedByString(" ").last!
            
            cell.updateTimeLabel.text = "今天" + timeStr
            
        }else {
            
            let presentDateFormatter = NSDateFormatter.init()
            
            presentDateFormatter.dateFormat = "MM-dd hh:mm"
            
            cell.updateTimeLabel.text = presentDateFormatter.stringFromDate(createDate)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! VRListModel
        
        let wvc = WebPagePresentationViewController()
        
        wvc.contentUrl = model.contentUrl
        
        self.delegate?.navigationController?.pushViewController(wvc, animated: true)
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}
