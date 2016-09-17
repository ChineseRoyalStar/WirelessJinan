//
//  GossipNavigationView.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class GossipNavigationView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    lazy var navigationCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal

        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let itemHeight:CGFloat = 40
        
        let collectionView = UICollectionView.init(frame: CGRectMake(0,0,kSCREEN_W,itemHeight),  collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib.init(nibName: "BoardCell", bundle: nil), forCellWithReuseIdentifier: "BoardCell")
        
        return collectionView
        
    }()

    lazy var underlineView: UIView = {
        
        let view = UIView.init(frame: CGRectMake(0, 35, kSCREEN_W/CGFloat(kBOARDS.count), 1))
        
        //view.backgroundColor = kSKY_BLUE
        
        return view
        
    }()
    
    
    weak var delegate: GossipViewController?
    
    var dataSource = NSMutableArray()
    
    var gossipIds = NSMutableArray()
    
    var widthOfTitleArr = [CGFloat]()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(navigationCollectionView)
        
        self.navigationCollectionView.addSubview(self.underlineView)
        
        self.prepareForTitleData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareForTitleData() {
        
        GossipTitleModel.requestForData { (titlesModels, error) in
            
            if error == nil {
                
                self.dataSource.removeAllObjects()
                
                self.dataSource.addObjectsFromArray(titlesModels!)
                
                //Calculate the width of titles
                self.calculateWidth()
                
                self.underlineView.backgroundColor = kSKY_BLUE
                
                self.navigationCollectionView.reloadData()
                
            }else {
                
                let alert = UIAlertController.init(title: "网络请求错误", message: "请检查网络", preferredStyle: .Alert)
                
                let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(action)
                
                self.delegate!.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func calculateWidth() {
        
        for titleModel in self.dataSource {
            
            self.gossipIds.addObject((titleModel as! GossipTitleModel).id)
            
            let titleStr = (titleModel as! GossipTitleModel).name as NSString
            
            let rect = titleStr.boundingRectWithSize(CGSizeMake(999, 30), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(20)], context: nil)
            
            self.widthOfTitleArr.append(rect.width)
            
        }
        
        self.delegate!.gossipListCollectionView.reloadData()
        
        self.underlineView.frame.size.width = self.widthOfTitleArr[0]
    }
    
    func calculateOriginXoIndex(index:Int) -> CGFloat{
        
        var totalWidth: CGFloat = 0
        
        if index == 0 {
            
            return 0
            
        }
        
        for i in 0...index-1 {
            
            totalWidth += self.widthOfTitleArr[i]
        }
        
        return totalWidth
    }
    
    

    
    //MARK:- UICollectionView and UIFlowLayoutDelegate Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BoardCell", forIndexPath: indexPath) as! BoardCell
        
        let title = self.dataSource.objectAtIndex(indexPath.row) as! GossipTitleModel
        
        cell.boardTitleLabel.text = title.name
        
        cell.boardTitleLabel.font = UIFont.boldSystemFontOfSize(14)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
        self.underlineView.frame.size.width = self.widthOfTitleArr[indexPath.row]
        
        UIView.animateWithDuration(0.2) {
            
            self.underlineView.frame.origin.x = self.calculateOriginXoIndex(indexPath.row)
            
        }
        
        self.delegate?.gossipListCollectionView.contentOffset.x = CGFloat(indexPath.row * Int(kSCREEN_W))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return CGSizeMake(self.widthOfTitleArr[indexPath.row], 30)
        
    }
    
    

}
