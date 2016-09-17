//
//  MyInfoHeaderView.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

class MyInfoHeaderView: UIView {

    
    var portraitsImageView: UIImageView!
    
    var nickNameLabel: UILabel!
    
    var leveLabel: UILabel!
    
    var signInBtn: UIButton!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepareLayoutForHeadView()
        
    }
    
    
    func prepareLayoutForHeadView() -> Void {
        
        portraitsImageView = UIImageView()
        
        self.addSubview(portraitsImageView)
        
        portraitsImageView.snp_makeConstraints { (make) in
            
            make.top.equalToSuperview().offset(30)
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(70)
            
            make.height.equalTo(70)
            
        }
        
        portraitsImageView.image = UIImage.init(named: "baoliao")
        
        portraitsImageView.layer.cornerRadius = portraitsImageView.frame.height/2
        
        portraitsImageView.clipsToBounds = true
        
        
        nickNameLabel = UILabel()
        
        self.addSubview(nickNameLabel)
        
        nickNameLabel.textAlignment = NSTextAlignment.Center
        
        nickNameLabel.text = "少年灬听雨"
        
        nickNameLabel.textColor = UIColor.whiteColor()
        
        nickNameLabel.font = UIFont.boldSystemFontOfSize(20)
        
        nickNameLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(portraitsImageView.snp_bottom).offset(20)
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(100)
            
            make.height.equalTo(30)
            
        }
        
        
        leveLabel = UILabel()
        
        self.addSubview(leveLabel)
        
        leveLabel.textAlignment = NSTextAlignment.Center
        
        leveLabel.text = "Level"
        
        leveLabel.textColor = UIColor.whiteColor()
        
        leveLabel.font = UIFont.systemFontOfSize(14)
        
        leveLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(nickNameLabel.snp_bottom).offset(10)
            
            make.centerX.equalToSuperview()
            
            make.width.equalTo(100)
            
            make.height.equalTo(30)
            
        }
        
        
        //签到按钮
        signInBtn = UIButton.init(frame: CGRectMake(0, 0, 100, 50))
        
        self.addSubview(signInBtn)
        
        signInBtn.setTitle("签到", forState: .Normal)
        
        signInBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        signInBtn.addTarget(self, action: #selector(self.signInAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        signInBtn.snp_makeConstraints { (make) in
            
            make.top.equalTo(leveLabel.snp_bottom).offset(10)
            
            make.centerX.equalTo(leveLabel)
            
            make.width.equalTo(100)
            
            make.height.equalTo(50)
            
        }
        
        signInBtn.layer.cornerRadius = signInBtn.bounds.height/2
        
        signInBtn.layer.borderWidth = 1
        
        signInBtn.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
    func signInAction() -> Void {
        
        print("登陆操作")
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
