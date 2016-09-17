//
//  TopicViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

import MBProgressHUD

class TopicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataSource = NSMutableArray()
    
    var offset: Int = 0
    
    var homeUrl: String?
    
    lazy var tableView: UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-64), style: UITableViewStyle.Plain)
        
        table.dataSource = self
        
        table.delegate = self
        
        table.showsVerticalScrollIndicator = false
        
        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.offset = 0
            
            self.prepareForAlbumData(OperationState.PullDown)
            
        })
        
        table.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.offset += 20
            
            self.prepareForAlbumData(OperationState.PullUp)
        })
        
        table.mj_footer.automaticallyHidden = true
        
        table.registerNib(UINib.init(nibName: "AlbumListCell", bundle: nil), forCellReuseIdentifier: "AlbumListCell")
        
        self.view.addSubview(table)
        
        return table
    }()
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
       // self.view.addSubview(self.tableView)
        
        self.prepareForAlbumData(OperationState.PullDown)
    }
    
    
    func prepareForAlbumData(op:OperationState) {
        
        self.progress.showAnimated(true)
        
        PictureModel.requestForPicAlbumData(homeUrl!, offset: self.offset) { (picModels, error) in
            
            if error == nil {
                
                if op == OperationState.PullDown {
                    
                    self.dataSource.removeAllObjects()
                    
                    for model in picModels! {
                        
                        if (model as! PictureModel).outlink == "" {
                            
                            self.dataSource.addObject(model)
                            
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    
                }else {
                    
                    for model in picModels! {
                        
                        if (model as! PictureModel).outlink == "" {
                            
                            self.dataSource.addObject(model)
                            
                        }
                        
                    }
        
                    self.tableView.reloadData()
                    
                }
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            self.progress.hideAnimated(true)
            
            self.tableView.mj_header.endRefreshing()
            
            self.tableView.mj_footer.endRefreshing()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- UITableView Deletgate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumListCell", forIndexPath: indexPath) as! AlbumListCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! PictureModel
        
        cell.imageView?.image = nil
        
        cell.briefDecLabel.text = model.title
        
        
        let imgUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
        
        cell.picImageView.sd_setImageWithURL(NSURL.init(string: imgUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kSCREEN_H/3
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! PictureModel
        
        let tvc = TopicDetailViewController()
        
        tvc.navigationItem.titleView = UITools.navTitleLabel(model.title)
        
        tvc.id = model.contentFromId
        
        self.navigationController?.pushViewController(tvc, animated: true)
        
        
        
    }
    
}
