//
//  MyInfoViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

    
    lazy var headerView: MyInfoHeaderView = {
        
       let header = MyInfoHeaderView.init(frame: CGRectMake(0, 64, kSCREEN_W, kSCREEN_H/3 + 50))
        
        header.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        
        return header
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerView)
        
        self.navigationItem.titleView = UITools.navTitleLabel("我的")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
