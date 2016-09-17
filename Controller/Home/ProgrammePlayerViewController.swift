//
//  ProgrammePlayerViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/2.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import AVFoundation

import AVKit

import SnapKit

class ProgrammePlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProgrammeDetailListCellDelegate, AVPlayerViewControllerDelegate{
    
    var url: String! //当前直播视频url
    
    var channelId: String! //频道id
    
    var currentZone: Int!
    
    lazy var playerVC: AVPlayerViewController = {
        
        let player = AVPlayerViewController.init()
        
        player.showsPlaybackControls = true
        
        player.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        player.view.frame = CGRectMake(0, 64, kSCREEN_W, kSCREEN_W*2/3)
        
        player.player = AVPlayer.init(URL: NSURL.init(string: self.url)!)
        
        //player.delegate = self
        
        self.view.addSubview(player.view)
        
        return player
        
    }()
    
    lazy var programmeListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.itemSize = CGSizeMake(kSCREEN_W, kSCREEN_H-kSCREEN_W*2/3-64-40)
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let programmeList = UICollectionView.init(frame: CGRectMake(0, 64+40+kSCREEN_W*2/3, kSCREEN_W, kSCREEN_H-kSCREEN_W*2/3-64-40), collectionViewLayout: layout)
        
        programmeList.registerNib(UINib.init(nibName: "ProgrammeDetailListCell", bundle: nil), forCellWithReuseIdentifier: "ProgrammeDetailListCell")
        
        programmeList.backgroundColor = UIColor.whiteColor()
        
        programmeList.pagingEnabled = true
        
        programmeList.delegate = self
        
        programmeList.dataSource = self
        
        return programmeList
        
    }()
    
    
    lazy var navigationView: NavigationView = {
        
        let weeks = ["周一","周二","周三","周四","周五","周六","周日"]
        
        let navi = NavigationView.init(frame: CGRectMake(0, 64+self.playerVC.view.frame.height, kSCREEN_W, 40),dataSource: weeks)
        
        navi.delegate = self
        
        return navi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.navigationView)
        
        self.view.addSubview(self.programmeListCollectionView)
        
        self.playerVC.player = AVPlayer.init(URL: NSURL.init(string: url)!)
        
        self.playerVC.player?.play()
        
        self.performSelector(#selector(moveToToday), withObject: nil, afterDelay: 2)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.playerVC.player!.pause()

    }
    
    
    func moveToToday() {
        
        var week: CGFloat
        
        if NSDate().dayOfWeek() == 0 {
            
            week = 6
            
        }else {
            
            week = CGFloat(NSDate().dayOfWeek() - 1)
            
        }
        
        self.programmeListCollectionView.contentOffset.x =  week * kSCREEN_W
        
        self.scrollViewDidEndDecelerating(self.programmeListCollectionView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK:- ProgrammeDetailListCellDelegate Methods
    
    func changePlayingUrlTo(url: String) {
        
        self.playerVC.player = nil
        
        self.playerVC.player = AVPlayer.init(URL:NSURL.init(string: url)!)
        
        self.playerVC.player?.play()
        
    }
    
    //MARK:- UICollectionViewDelegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProgrammeDetailListCell", forIndexPath: indexPath) as! ProgrammeDetailListCell
        
        cell.delegate = self
        
        cell.dataSource.removeAllObjects()
        
        cell.tableView.reloadData()
        
        
        var zone: Int
        
        if NSDate().dayOfWeek() == 0 {
            
            zone = indexPath.row + 1 - 7
            
        }else {
            
            zone = indexPath.row + 1 - NSDate().dayOfWeek()
            
        }
        
        ProgrammeListModel.requestForProgrammeListData(self.channelId, zone: String(zone)) { (modelArr, error) in
            
            if error == nil {
                
                cell.dataSource.addObjectsFromArray(modelArr!)
                
                cell.tableView.reloadData()

                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        
        return cell
    }
    
    
    //MARK:- UIScrollViewDelegate Methods
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.programmeListCollectionView {
            
            let index = Int(self.programmeListCollectionView.contentOffset.x/kSCREEN_W)
            
            self.navigationView.collectionView(self.navigationView.navigationCollectionView, didSelectItemAtIndexPath: NSIndexPath.init(forItem: index, inSection: 0))
            
        }
    }
    
}
