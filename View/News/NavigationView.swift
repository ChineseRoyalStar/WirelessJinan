//
//  NavigationView.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/13.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class NavigationView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    lazy var navigationCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = 0
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let itemWidth:CGFloat = kSCREEN_W/CGFloat(self.dataSource.count)
        
        let itemHeight:CGFloat = 30
        
        layout.itemSize = CGSizeMake(itemWidth, itemHeight)
        
        let collectionView = UICollectionView.init(frame: CGRectMake(0,0,kSCREEN_W,itemHeight),  collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib.init(nibName: "BoardCell", bundle: nil), forCellWithReuseIdentifier: "BoardCell")
        
        return collectionView
        
    }()
    
    lazy var underlineView: UIView = {
        
        let view = UIView.init(frame: CGRectMake(0, 30-1, kSCREEN_W/CGFloat(self.dataSource.count), 2))
        
        view.backgroundColor = kSKY_BLUE
        
        return view
        
    }()
    
    weak var delegate: UIViewController?
    
    var dataSource:[String]!
    
    var selectedBoardIndex: NSIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
    
    init(frame: CGRect,dataSource:[String]) {
        super.init(frame: frame)
        
        self.dataSource = dataSource
        
        self.addSubview(navigationCollectionView)
        
        self.navigationCollectionView.addSubview(self.underlineView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- UICollectionView and UIFlowLayoutDelegate Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BoardCell", forIndexPath: indexPath) as! BoardCell
        
        if indexPath.row == self.selectedBoardIndex.row {
            
            cell.boardTitleLabel.textColor = kSKY_BLUE
            
        }
        
        let title = self.dataSource[indexPath.row]
        
        cell.boardTitleLabel.text = title
        
        cell.boardTitleLabel.font = UIFont.boldSystemFontOfSize(18)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        (collectionView.cellForItemAtIndexPath(self.selectedBoardIndex) as! BoardCell).boardTitleLabel.textColor = UIColor.blackColor()
    
        (collectionView.cellForItemAtIndexPath(indexPath) as! BoardCell).boardTitleLabel.textColor = kSKY_BLUE
        
        self.selectedBoardIndex = indexPath
        
        UIView.animateWithDuration(0.2) {
            
            self.underlineView.frame.origin.x = kSCREEN_W/CGFloat(self.dataSource.count) * CGFloat(indexPath.row)
            
        }
        
        if (self.delegate!).isKindOfClass(NewsViewController.self) {
            
            (self.delegate as! NewsViewController).newsListCollectionView.contentOffset.x = CGFloat(indexPath.row) * kSCREEN_W
          
        }else if (self.delegate!).isKindOfClass(ProgrammePlayerViewController.self) {
            
            (self.delegate as! ProgrammePlayerViewController).programmeListCollectionView.contentOffset.x = CGFloat(indexPath.row) * kSCREEN_W
        }
            
    }

}
