//
//  NewsViewController.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/13.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

import SnapKit

import MBProgressHUD

class NewsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    var navigationBoard: NavigationView?
    
    var skipToHtmlOfId: String?
    
    lazy var progress: MBProgressHUD = {
        
        let prog = MBProgressHUD.init()
        
        prog.frame = CGRectMake(0, 0, 200, 200)
        
        prog.center = self.view.center
        
        prog.detailsLabel.text = "正在加载..."
        
        self.view.addSubview(prog)
        
        return prog
        
    }()
    
    lazy var newsListCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSizeMake(kSCREEN_W, kSCREEN_H - 64 - self.navigationBoard!.frame.size.height - 49)
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        
        let collection = UICollectionView.init(frame: CGRectMake(0, 64 + self.navigationBoard!.frame.size.height, kSCREEN_W, kSCREEN_H - 64 - self.navigationBoard!.frame.size.height - 49), collectionViewLayout: layout)
        
        
        collection.backgroundColor = UIColor.whiteColor()
        
        collection.delegate = self
        
        collection.dataSource = self
        
        collection.pagingEnabled = true
        
        collection.registerNib(UINib.init(nibName: "BoardListCell", bundle: nil), forCellWithReuseIdentifier: "BoardListCell")
        
        return collection
        
    }()
    
    
    //数据源
    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.titleView = UITools.navTitleLabel("我的")
        
        self.createNavigationBoard()
        
        self.view.addSubview(self.newsListCollectionView)
        
    }

    func createNavigationBoard() {
        
        self.navigationBoard = NavigationView.init(frame: CGRectMake(0, 64, kSCREEN_W, 40),dataSource: kBOARDS)
        
        self.navigationBoard?.delegate = self
        
        // self.navigationBoard?.dataSource = kBOARDS
        
        self.view.addSubview(self.navigationBoard!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return kBOARDS.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.newsListCollectionView.dequeueReusableCellWithReuseIdentifier("BoardListCell", forIndexPath: indexPath) as! BoardListCell
        
        cell.delegate = self
        
        cell.boardIndex = indexPath.row
        
        //加载下个板块前,将数据源清空,刷新tableview
        cell.dataSource.removeAllObjects()
        
        cell.tableHeaderViewImage?.image = nil
        
        cell.titleDescriptionLabel = nil
        
        cell.tableView.reloadData()
        
        
        self.progress.showAnimated(true)
        
        RequestForNewsData.requestForNewsData(indexPath.row, offset: 0){ (newsArr, title, error) in
            
            if error == nil{
                
                if title != nil {
                    
                    cell.tableHeaderViewImage = UIImageView()
                    
                    cell.tableHeaderViewImage!.frame = CGRectMake(0, 0, kSCREEN_W, kSCREEN_W/2)
                    
                    cell.tableHeaderViewImage?.userInteractionEnabled = true
                    
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction))
                    
                    cell.tableHeaderViewImage?.addGestureRecognizer(tap)
                    
                    cell.tableView.tableHeaderView = cell.tableHeaderViewImage
                    
                    let imageUrl = (title?.indexpic.host)! + (title?.indexpic.dir)! + (title?.indexpic.filepath)! + (title?.indexpic.filename)!
                    
                    cell.tableHeaderViewImage!.sd_setImageWithURL(NSURL.init(string: imageUrl),placeholderImage: UIImage.init(named: "placeholder.jpg"))
                    
                    
                    cell.titleDescriptionLabel = UILabel()
                    
                    cell.tableHeaderViewImage!.addSubview(cell.titleDescriptionLabel!)
                    
                    cell.titleDescriptionLabel!.font = UIFont.systemFontOfSize(18)
                    
                    cell.titleDescriptionLabel!.textColor = UIColor.whiteColor()
                    
                    cell.titleDescriptionLabel!.snp_makeConstraints(closure: { (make) in
                        
                        make.left.equalToSuperview().offset(10)
                        
                        make.bottom.equalToSuperview().offset(-10)
                        
                        make.right.equalToSuperview()
                        
                        make.height.equalTo(15)
                        
                    })
                    
                    cell.titleDescriptionLabel!.text = title?.title
                    
                    self.skipToHtmlOfId = title?.id
                    
                }else {
                    
                    cell.titleDescriptionLabel?.removeFromSuperview()
                    
                    cell.tableHeaderViewImage?.removeFromSuperview()
                    
                    cell.tableView.tableHeaderView = nil
                }
                
                cell.dataSource.addObjectsFromArray(newsArr!)
                
                cell.tableView.reloadData()
                
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
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(kSCREEN_W, kSCREEN_H - 64 - self.navigationBoard!.frame.size.height - 49)
        
    }
    
    
    func tapAction() {
        
        let vc = NewsDetailViewController()
        
        vc.hidesBottomBarWhenPushed = true
        
        vc.contentId = self.skipToHtmlOfId
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.newsListCollectionView {
            
            let index = Int(self.newsListCollectionView.contentOffset.x/kSCREEN_W)
            
            self.navigationBoard?.collectionView((self.navigationBoard?.navigationCollectionView)!, didSelectItemAtIndexPath: NSIndexPath.init(forItem: index, inSection: 0))
            
        }
    }
    
}
