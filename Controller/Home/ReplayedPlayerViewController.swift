//
//  ReplayedPlayerViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

import AVKit

import AVFoundation

class ReplayedPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id: String!
    
    lazy var playerVC: AVPlayerViewController = {
        
        let player = AVPlayerViewController.init()
        
        player.showsPlaybackControls = true
        
        player.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        player.view.frame = CGRectMake(0, 64, kSCREEN_W, kSCREEN_W*2/3)
        
        return player
    }()
    
    lazy var tableView: UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0, 64+kSCREEN_W*2/3, kSCREEN_W, kSCREEN_H-kSCREEN_W*2/3-64), style: UITableViewStyle.Grouped)
        
        table.delegate = self
        
        table.dataSource = self
        
        table.registerNib(UINib.init(nibName: "ProgrammePlaylistCell", bundle: nil), forCellReuseIdentifier:"ProgrammePlaylistCell")
        
        self.view.addSubview(table)
        
        return table
        
    }()
    
    var dataSource: NSMutableArray = NSMutableArray()
    
    var selectedIndexPath: NSIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.prepareForPlaylist()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.playerVC.player!.pause()
    }
    
    
    func prepareForPlaylist() {
        
        ProgrammeDetailModel.requestForProgrammeDetail(self.id!) { (programmeModels, error) in
            
            if error == nil {
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(programmeModels!)
                
                self.tableView.reloadData()
                
                self.view.addSubview(self.playerVC.view)
                
                let audioModel = (self.dataSource.objectAtIndex(0) as! ProgrammeDetailModel).video
                
                let audioUrl = audioModel.host + "/" + audioModel.filepath + audioModel.filename
                
                self.playerVC.player = AVPlayer.init(URL:NSURL.init(string: audioUrl)!)
                
                self.playerVC.player?.play()
                
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProgrammePlaylistCell", forIndexPath: indexPath) as! ProgrammePlaylistCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeDetailModel
        
        cell.programmeNameLabel.textColor = UIColor.blackColor()
        
        cell.playImgView.image = UIImage.init(named:"live_item_play")
        
        if indexPath.row == self.selectedIndexPath.row {
            
            cell.programmeNameLabel.textColor = kSKY_BLUE
            
            cell.playImgView.image = UIImage.init(named:"live_item_play_now")
            
        }
        
        cell.programmeNameLabel.text = model.columnName
        
        cell.updateTimeLabel.text = (model.publishTime as NSString).componentsSeparatedByString(" ").first!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        if indexPath.row != self.selectedIndexPath.row {
            
            for index in tableView.indexPathsForVisibleRows! {
                
                if index.row == self.selectedIndexPath.row {
                    
                    let preCell = tableView.cellForRowAtIndexPath(self.selectedIndexPath) as! ProgrammePlaylistCell
                    
                    preCell.programmeNameLabel.textColor = UIColor.blackColor()
                    
                    preCell.playImgView.image = UIImage.init(named:"live_item_play")
                    
                    break
                }
                
            }
            
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ProgrammePlaylistCell
            
            cell.programmeNameLabel.textColor = kSKY_BLUE
            
            cell.playImgView.image = UIImage.init(named:"live_item_play_now")
            
            self.selectedIndexPath = indexPath
            
            
            let audioModel = (self.dataSource.objectAtIndex(indexPath.row) as! ProgrammeDetailModel).video
            
            let audioUrl = audioModel.host + "/" + audioModel.filepath + audioModel.filename
            
            self.playerVC.player = nil
            
            self.playerVC.player = AVPlayer.init(URL: NSURL.init(string: audioUrl)!)

            self.playerVC.player?.play()
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRectMake(0, 0, kSCREEN_W, 50))
        
        let label = UILabel()
        
        view.addSubview(label)
        
        label.snp_makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(15)
            
            make.left.equalToSuperview().offset(10)
            
            make.height.equalTo(21)
            
        }
        
        label.text = "选集"
        
        
        let updateLabel = UILabel()
        
        view.addSubview(updateLabel)
        
        updateLabel.snp_makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(15)
            
            make.right.equalToSuperview().offset(-10)
            
            make.height.equalTo(21)
            
        }
        
        
        let timeStr = ((self.dataSource.objectAtIndex(0) as! ProgrammeDetailModel).publishTime as NSString).componentsSeparatedByString(" ").first!

        let dateStr = (timeStr as NSString).componentsSeparatedByString("-").joinWithSeparator("")
        
        updateLabel.font = UIFont.systemFontOfSize(15)
        
        updateLabel.text = "更新至" + dateStr
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
