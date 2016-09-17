//
//  BoardListCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/14.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

import SDWebImage

enum OperationState {
    
    case PullDown
    
    case PullUp
    
}

class BoardListCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var titleDescriptionLabel: UILabel? = {
        
        let label = UILabel()
        
        self.tableHeaderViewImage!.addSubview(label)
        
        label.font = UIFont.systemFontOfSize(18)
        
        label.textColor = UIColor.whiteColor()
        
        label.snp_makeConstraints(closure: { (make) in
            
            make.left.equalToSuperview().offset(10)
            
            make.bottom.equalToSuperview().offset(-10)
            
            make.right.equalToSuperview()
            
            make.height.equalTo(15)
            
        })
        
        return label
    }()
    
    weak var delegate: NewsViewController?
    
    var tableHeaderViewImage:UIImageView?
    
    var dataSource = NSMutableArray()
    
    var boardIndex: Int?
    
    var currentOffset = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.tableView.dataSource = self
        
        self.tableView.delegate = self
        
        self.tableHeaderViewImage = UIImageView()
        
        self.tableHeaderViewImage!.frame = CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/2)
        
        self.tableView.tableHeaderView = self.tableHeaderViewImage
        
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.currentOffset = 0
            
            self.requestForData(self.boardIndex!,offset: 0,state: OperationState.PullDown)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.currentOffset += 20
            
            self.requestForData(self.boardIndex!, offset: self.currentOffset, state: OperationState.PullUp)
            
        })
        
        self.tableView.mj_footer.automaticallyHidden = true
        
        self.tableView.registerNib(UINib.init(nibName: "BoardNewsCell", bundle: nil), forCellReuseIdentifier: "BoardNewsCell")
        
    }
    
    
    func requestForData(boardIndex:Int,offset:Int,state:OperationState) -> Void {
        
        RequestForNewsData.requestForNewsData(boardIndex,offset: offset) { (newsArr, title, error) in
            
            
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("BoardNewsCell", forIndexPath: indexPath) as! BoardNewsCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! NewsModel
        
        let imgUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
        
        cell.iconImageView.sd_setImageWithURL(NSURL.init(string: imgUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        cell.detailLabel.attributedText = UITools.attributedStringWithLineSpace(model.title, sizeOfFont: 16, lineSpace: 5)
        
        
        let publishDate = NSDate.init(timeIntervalSince1970:NSTimeInterval.init(model.publishTimeStamp)!)
        
        let dateFormat = NSDateFormatter.init()
        
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        cell.updateTimeLabel.text = dateFormat.stringFromDate(publishDate)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return kSCREEN_H/7
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! NewsModel
        
        let newsVC = NewsDetailViewController()
        
        newsVC.contentId = model.id
        
        newsVC.navigationItem.titleView = UITools.navTitleLabel(model.columnName)
        
        newsVC.hidesBottomBarWhenPushed = true
        
        self.delegate!.navigationController?.pushViewController(newsVC, animated: true)
        
        
    }
    
}
