//
//  headerView.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

class HeaderView: UIView, UIScrollViewDelegate {
    
    //advertisement view, lazy loading
    
    lazy var adView:XTADScrollView = {
        
        let view = XTADScrollView.init(frame: CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/3))
        
        view.infiniteLoop = true
        
        view.needPageControl = true
        
        // view.pageControlPositionType = pageControlPositionTypeRight
        
        view.imageURLArray = [AnyObject]()
        
        return view
    }()
    
    //icon view, lazy loading
    lazy var iconView: UIScrollView = {
        
        let view = UIScrollView()
        
        view.frame = CGRectMake(0, kSCREEN_W/3, kSCREEN_W,kBTNHEIGHT*2+kINTERSPACE+40)
        
        view.contentSize = CGSizeMake(kSCREEN_W * 2, kBTNHEIGHT*2+kINTERSPACE+40)
        
        view.pagingEnabled = true
        
        view.delegate = self
        
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        
        self.iconView.addSubview(pageControl)
        
        pageControl.numberOfPages = 2
        
        pageControl.snp_makeConstraints(closure: { (make) in
            
            make.centerX.equalTo(self)
            
            make.bottom.equalTo(self).offset(-5)
            
            make.width.equalTo(20)
            
            make.height.equalTo(5)
            
        })
        
        
        return pageControl
    }()
    
    
    weak var delegate: UIViewController?
    
    //Constructor
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(adView)
        
        self.addSubview(iconView)
        
        self.pageControl.currentPage = 0
        
    }
    
    
    func createButtons() -> Void {
        
        var preBtn: UIButton?
        
        for i in 0...kTITLES.count-1 {
            
            let button = UIButton.init()
            
            button.tag = 1000 + i
            
            button.setImage(UIImage.init(named: kBUTTON[i]), forState: .Normal)
            
            button.setImage(UIImage.init(named: kBUTTON[i]), forState: .Highlighted)
            
            button.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: .TouchUpInside)
            
            self.iconView.addSubview(button)
            
            if i == 0 {
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    make.top.equalToSuperview().offset(kPADDING - 10)
                    
                    make.left.equalToSuperview().offset(kPADDING)
                    
                    make.width.equalTo(kBTNWIDTH)
                    
                    make.height.equalTo(kBTNHEIGHT)
                    
                })
                
                preBtn = button
                
            }else if i == 4 {
                
                let btn = self.iconView.viewWithTag(1000) as! UIButton
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    make.top.equalTo(btn.snp_bottom).offset(kPADDING+10)
                    
                    make.left.equalToSuperview().offset(kPADDING)
                    
                    make.width.equalTo(kBTNWIDTH)
                    
                    make.height.equalTo(kBTNHEIGHT)
                    
                })
                
                preBtn = button
                
            }else if i == 8 {
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    make.top.equalToSuperview().offset(kPADDING-10)
                    
                    make.left.equalToSuperview().offset(kSCREEN_W+kPADDING)
                    
                    make.width.equalTo(kBTNWIDTH)
                    
                    make.height.equalTo(kBTNHEIGHT)
                    
                })
                
                preBtn = button
                
            }else if i == 12 {
                
                let btn = self.iconView.viewWithTag(1008) as! UIButton
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    make.top.equalTo(btn.snp_bottom).offset(kPADDING+10)
                    
                    make.left.equalToSuperview().offset(kSCREEN_W+kPADDING)
                    
                    make.width.equalTo(kBTNWIDTH)
                    
                    make.height.equalTo(kBTNHEIGHT)
                    
                })
                
                preBtn = button
                
            }else if i/4 == 0 || i/4 == 2 {
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    make.left.equalTo((preBtn?.snp_right)!).offset(kINTERSPACE)
                    
                    make.top.equalTo((preBtn?.snp_top)!)
                    
                    make.width.equalTo(kBTNWIDTH)
                    
                    make.height.equalTo(kBTNHEIGHT)
                    
                })
                
                preBtn = button
                
            }else if i/4 == 1 || i/4 == 3 {
                
                button.snp_makeConstraints(closure: { (make) in
                    
                    button.snp_makeConstraints(closure: { (make) in
                        
                        make.left.equalTo((preBtn?.snp_right)!).offset(kINTERSPACE)
                        
                        make.top.equalTo((preBtn?.snp_top)!)
                        
                        make.width.equalTo(kBTNWIDTH)
                        
                        make.height.equalTo(kBTNHEIGHT)
                        
                    })
                    
                    preBtn = button
                    
                })
                
            }
            
            
            let label = UILabel()
            
            label.text = kTITLES[i]
            
            label.textAlignment = NSTextAlignment.Center
            
            label.font = UIFont.boldSystemFontOfSize(13)
            
            self.iconView.addSubview(label)
            
            label.snp_makeConstraints(closure: { (make) in
                
                make.top.equalTo((preBtn?.snp_bottom)!).offset(5)
                
                make.centerX.equalTo((preBtn?.snp_centerX)!)
                
                make.height.equalTo(kLABELHEIGHT)
                
                make.width.equalTo((preBtn?.snp_width)!).offset(30)
            })
            
            
        }
        
        self.pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        
        self.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        
    }
    
    
    
    func btnClick(btn:UIButton) {
        
        if btn.tag == 1000 {
            
            let pvc = ProgrammeViewController()
            
            pvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/channel.php"
            
            pvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            pvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(pvc, animated: true)
            
        }else if btn.tag == 1001 {
            
            let pvc = ProgrammeViewController()
            
            pvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/gb_channel.php?"
            
            pvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            pvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(pvc, animated: true)
            
            
        }else if btn.tag == 1002 {
            
            let rpvc = ReplayedProgrammeViewController()
            
            rpvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/column.php?"
            
            rpvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            rpvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(rpvc, animated: true)
            
            
        }else if btn.tag == 1003 {
            
            let rpvc = ReplayedProgrammeViewController()
            
            rpvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/gb_column.php"
            
            rpvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            rpvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(rpvc, animated: true)
            
        }else if btn.tag == 1004 {
            
            let cvc = CommunityViewController()
            
            cvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            cvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(cvc, animated: true)
            
        }else if btn.tag == 1005 {
            
            let vvc = VRChannelViewController()
            
            vvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            vvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(vvc, animated: true)
            
            
        }else if btn.tag == 1006 {
            
            let gvc = GossipViewController()
            
            gvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            gvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(gvc, animated: true)
            
            
        }else if btn.tag == 1007 {
            
            let pvc = PictureViewController()
            
            pvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/news_tp.php"
            
            pvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            pvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(pvc, animated: true)
            
            
        }else if btn.tag == 1008 {
            
            let tvc = TopicViewController()
            
            tvc.homeUrl = "http://pmobile.ijntv.cn/ijntv30/zt_news.php"
            
            tvc.navigationItem.titleView = UITools.navTitleLabel(kTITLES[btn.tag - 1000])
            
            tvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(tvc, animated: true)
            
        }else if btn.tag == 1009 {
            
            let tvc = GDTrafficSituationViewController()
            
            tvc.hidesBottomBarWhenPushed = true
            
            self.delegate?.navigationController?.pushViewController(tvc, animated: true)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UIScrollViewDelegate Methods
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let currentPage = self.iconView.contentOffset.x / kSCREEN_W
        
        self.pageControl.currentPage = Int(currentPage)
        
    }
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
