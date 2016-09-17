//
//  GossipViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MBProgressHUD

class GossipViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var gossipNavigation: GossipNavigationView?
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    lazy var gossipListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSizeMake(kSCREEN_W, kSCREEN_H - 64 - self.gossipNavigation!.frame.size.height)
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collection = UICollectionView.init(frame: CGRectMake(0, 64 + self.gossipNavigation!.frame.size.height, kSCREEN_W, kSCREEN_H - 64 - self.gossipNavigation!.frame.size.height), collectionViewLayout: layout)
        
        collection.backgroundColor = UIColor.whiteColor()
        
        collection.delegate = self
        
        collection.dataSource = self
        
        collection.pagingEnabled = true
        
        collection.registerNib(UINib.init(nibName: "GossipCommentListCell", bundle: nil), forCellWithReuseIdentifier: "GossipCommentListCell")
        
        return collection
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.gossipNavigation = GossipNavigationView.init(frame: CGRectMake(0, 64, kSCREEN_W, 40))
        
        self.gossipNavigation?.delegate = self
        
        self.view.addSubview(self.gossipNavigation!)
        
        self.view.addSubview(self.gossipListCollectionView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UICollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.gossipNavigation?.gossipIds.count)!
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.gossipListCollectionView.dequeueReusableCellWithReuseIdentifier("GossipCommentListCell", forIndexPath: indexPath) as! GossipCommentListCell
        
        //Clear the datasource all before change the board
        cell.dataSource.removeAllObjects()
        
        cell.tableView.reloadData()
        
        self.progress.showAnimated(true)
        GossipCommentModel.requestForGossipCommentData(self.gossipNavigation?.gossipIds[indexPath.row] as! String, offset: 0) { (commentModels, error) in
            
            if error == nil {
                
                cell.dataSource.addObjectsFromArray(commentModels!)
                
                cell.tableView.reloadData()
                
                cell.id = (self.gossipNavigation?.gossipIds[indexPath.row] as! String)
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            self.progress.hideAnimated(true)
        }
        
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.gossipListCollectionView {
            
            let index = Int(self.gossipListCollectionView.contentOffset.x/kSCREEN_W)
            
            let contentX = self.gossipNavigation?.calculateOriginXoIndex(index)
            
            self.gossipNavigation?.navigationCollectionView.contentOffset.x = contentX!
            
            self.gossipNavigation?.collectionView((self.gossipNavigation?.navigationCollectionView)!, didSelectItemAtIndexPath: NSIndexPath.init(forItem: index, inSection: 0))
            
        }
    }
    
    
}
