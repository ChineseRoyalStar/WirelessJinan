//
//  DiscoveryViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import MJRefresh

class DiscoveryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    lazy var tableView:UITableView = {
        
        let table = UITableView.init(frame: CGRectMake(0,64, kSCREEN_W, kSCREEN_H - 64 - 44), style:UITableViewStyle.Plain)
        
        table.registerNib(UINib.init(nibName: "ModuleForumCell", bundle: nil), forCellReuseIdentifier: "ModuleForumCell")
        
        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.requestForDataSource()
            
        })
        
        table.delegate = self
        
        table.dataSource = self
        
        table.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        return table
        
    }()
    
    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "发现"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(self.tableView)
        
        requestForDataSource()
        
    }
    
    
    func requestForDataSource() -> Void {
        
        ModuleModel.requestDataForModules { (moduleArr, error) in
            
            
            if error == nil{
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(moduleArr!)
                
                self.tableView.reloadData()
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            self.tableView.mj_header.endRefreshing()
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.dataSource.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  self.tableView.dequeueReusableCellWithIdentifier("ModuleForumCell", forIndexPath: indexPath) as! ModuleForumCell
        
        //Remove all objects in datasource and Refresh collectionview
        cell.dataSource.removeAllObjects()
        
        cell.moduleCollectionView.reloadData()
        
        let model = self.dataSource.objectAtIndex(indexPath.section) as! ModuleModel
        
        cell.dataSource.addObjectsFromArray(model.modules)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 2{
            
            return 2*(kSCREEN_W - kINTERSPACE2*5)/4 + 20*3 + 20*2
            
        }else {
            
            return (kSCREEN_W - kINTERSPACE2*5)/4 + 20*2 + 20
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return (self.dataSource[section] as! ModuleModel).name
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
