//
//  CommunityViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MBProgressHUD

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    
    lazy var adView: XTADScrollView = {
        
        let adView = XTADScrollView.init(frame: CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/3))
        
        adView.infiniteLoop = true
        
        adView.needPageControl = true
        
        adView.imageURLArray = [AnyObject]()
        
        return adView
        
    }()
    
    lazy var tableView: UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 64 , kSCREEN_W,  kSCREEN_H - 64), style: .Grouped)
        
        table.delegate = self
        
        table.dataSource = self
        
        table.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        table.tableHeaderView = self.adView
        
        table.registerNib(UINib.init(nibName: "CommunityCommentCell", bundle: nil), forCellReuseIdentifier: "CommunityCommentCell")
        
        table.registerNib(UINib.init(nibName:"CommunityWordCommentCell", bundle: nil), forCellReuseIdentifier: "CommunityWordCommentCell")
        
        self.view.addSubview(table)
        
        return table
    }()
    
    var dataSource = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.prepareDataForAdvertisement()
        
        self.prepareForCommentData()
        
    }
    
    
    func prepareDataForAdvertisement() {
        
        self.progress.showAnimated(true)
        
        AdvertisementModel.requestForAdvertisementData { (adModels, error) in
            
            if error == nil {
                
                self.adView.imageURLArray.removeAll()
                
                for ad in adModels! {
                    
                    let adModel = (ad as! AdvertisementModel).childsData.objectAtIndex(0) as! ChildModel
                    
                    let imgUrl = adModel.host + adModel.dir + adModel.filepath + adModel.filename
                    
                    self.adView.imageURLArray.append(imgUrl)
                    
                }
                
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
            
           self.progress.hideAnimated(true)
        }
        
    }
    
    func prepareForCommentData() -> Void {
        
        CommunityCommentModel.requestForCommentData { (commentModels, error) in
            
            if error == nil {
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(commentModels!)
                
                self.tableView.reloadData()
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UITableView Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! CommunityCommentModel
        
        
        if model.pics.count != 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CommunityCommentCell", forIndexPath: indexPath) as! CommunityCommentCell
            
            
            let userInfo = (self.dataSource.objectAtIndex(indexPath.row) as! CommunityCommentModel).userInfo
            
            cell.portraitImageView.layer.cornerRadius = cell.portraitImageView.frame.height / 2
            
            cell.portraitImageView.clipsToBounds = true
            
            if userInfo.avatar != nil {
                
                let portraitImageUrl = userInfo.avatar.host + userInfo.avatar.dir + userInfo.avatar.filepath + userInfo.avatar.filename
                
                cell.portraitImageView.sd_setImageWithURL(NSURL.init(string: portraitImageUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
                
            }
            
            
            cell.userNameLabel.text = userInfo.userName
            
            cell.dataSource.removeAllObjects()
            
            cell.collectionView.reloadData()
            
            let strArr = (model.createTimeFormat as NSString).componentsSeparatedByString(" ")
            
            cell.publishTimeLabel.text = strArr[0]
            
            cell.commentLabel.text = model.title
            
            cell.markLabel.text = model.forumTitle
            
            cell.markLabel.layer.borderWidth = 0.8
            
            cell.markLabel.layer.cornerRadius  = cell.markLabel.frame.height/2
            
            cell.markLabel.layer.borderColor = UIColor.blueColor().CGColor
            
            cell.clickNumLabel.text = model.clickNum
            
            cell.postNumLabel.text = model.postNum
            
            cell.dataSource.addObjectsFromArray(model.pics as [AnyObject])
            
            return cell
            
            
            
        }else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CommunityWordCommentCell", forIndexPath: indexPath) as! CommunityWordCommentCell
            
            
            let userInfo = (self.dataSource.objectAtIndex(indexPath.row) as! CommunityCommentModel).userInfo
            
            cell.portraitImageView.layer.cornerRadius = cell.portraitImageView.frame.height / 2
            
            cell.portraitImageView.clipsToBounds = true
            
            
            if userInfo.avatar != nil {
                
                let portraitImageUrl = userInfo.avatar.host + userInfo.avatar.dir + userInfo.avatar.filepath + userInfo.avatar.filename
                
                cell.portraitImageView.sd_setImageWithURL(NSURL.init(string: portraitImageUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
                
            }
            
            
            cell.userNameLabel.text = userInfo.userName
            
            let strArr = (model.createTimeFormat as NSString).componentsSeparatedByString(" ")
            
            cell.publishTimeLabel.text = strArr[0]
            
            cell.commentLabel.text = model.title
            
            cell.markLabel.text = model.forumTitle
            
            cell.markLabel.layer.borderWidth = 0.8
            
            cell.markLabel.layer.cornerRadius  = cell.markLabel.frame.height/2
            
            cell.markLabel.layer.borderColor = UIColor.blueColor().CGColor
            
            cell.clickNumLabel.text = model.clickNum
            
            cell.postNumLabel.text = model.postNum
            
            return cell
            
            
            
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! CommunityCommentModel
        
        let rect =  (model.forumTitle as NSString).boundingRectWithSize(CGSizeMake(kSCREEN_W - 8 - 8, 999), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSAttachmentAttributeName:16], context: nil)
        
        if model.pics.count != 0 {
            
            return rect.size.height + 270
            
        }else {
            
            return rect.size.height + 8 + 50 + 8 + 21 + 10 + 30
        }
        
    
    }
    
    
}
