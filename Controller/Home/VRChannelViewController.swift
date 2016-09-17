//
//  VRChannelViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MBProgressHUD

class VRChannelViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var vrChannelNavigation: VRNavigationView?
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    lazy var vrChannelListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSizeMake(kSCREEN_W, kSCREEN_H - 64 - self.vrChannelNavigation!.frame.size.height)
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collection = UICollectionView.init(frame: CGRectMake(0, 64 + self.vrChannelNavigation!.frame.size.height, kSCREEN_W, kSCREEN_H - 64 - self.vrChannelNavigation!.frame.size.height), collectionViewLayout: layout)
        
        collection.backgroundColor = UIColor.whiteColor()
        
        collection.delegate = self
        
        collection.dataSource = self
        
        collection.registerNib(UINib.init(nibName: "VRListCell", bundle: nil), forCellWithReuseIdentifier: "VRListCell")
        
        collection.pagingEnabled = true
        
        return collection
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.vrChannelNavigation = VRNavigationView.init(frame: CGRectMake(0, 64, kSCREEN_W, 40))
        
        self.vrChannelNavigation?.delegate = self
        
        self.view.addSubview(self.vrChannelNavigation!)
        
        self.view.addSubview(self.vrChannelListCollectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UICollectionViewDelegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.vrChannelNavigation?.vrIds.count)!
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VRListCell", forIndexPath: indexPath) as! VRListCell
        
        cell.dataSource.removeAllObjects()
        
        if cell.adsView.imageURLArray != nil {
            
            cell.adsView.imageURLArray.removeAll()
            
        }
        
        cell.tableView.reloadData()
        
        cell.delegate = self
        
        self.progress.showAnimated(true)
        
        VRListModel.requestForNewsData(self.vrChannelNavigation?.dataSource.objectAtIndex(indexPath.row) as! VRChannelModel, offset: 0) { (newsArr, ads, error) in
            
            if error == nil {
                
                cell.dataSource.addObjectsFromArray(newsArr!)
                
                for ad in ads!{
                    
                    let model = ad as! NewsModel
                    
                    let imgUrl = model.indexpic.host + model.indexpic.dir + model.indexpic.filepath + model.indexpic.filename
                    
                    cell.adsView.imageURLArray.append(imgUrl)
                    
                }
                
                cell.tableView.reloadData()
                
                cell.vrModel = (self.vrChannelNavigation?.dataSource.objectAtIndex(indexPath.row) as! VRChannelModel)
                
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
        
        if scrollView == self.vrChannelListCollectionView {
            
            let index = Int(self.vrChannelListCollectionView.contentOffset.x/kSCREEN_W)
            
           // let contentX = self.vrChannelNavigation?.calculateOriginXoIndex(index)
            
            //self.vrChannelNavigation?.navigationCollectionView.contentOffset.x = contentX!
            
            self.vrChannelNavigation?.collectionView((self.vrChannelNavigation?.navigationCollectionView)!, didSelectItemAtIndexPath: NSIndexPath.init(forItem: index, inSection: 0))
            
        }
        
    }
    
    
    
}
