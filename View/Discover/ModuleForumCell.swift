//
//  ModuleForumCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit


class ModuleForumCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var moduleCollectionView: UICollectionView!
    
    var dataSource =  NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.minimumInteritemSpacing = kINTERSPACE2
        
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: kINTERSPACE2, bottom: 20, right: kINTERSPACE2)
        
        layout.itemSize = CGSizeMake((kSCREEN_W - kINTERSPACE2*5)/4, (kSCREEN_W - kINTERSPACE2*5)/4 + 20)
        
        self.moduleCollectionView.registerNib(UINib.init(nibName: "ModuleCell", bundle: nil), forCellWithReuseIdentifier: "ModuleCell")
        
        self.moduleCollectionView.scrollEnabled = false
        
        self.moduleCollectionView.setCollectionViewLayout(layout, animated: false)
        
        self.moduleCollectionView.delegate = self
        
        self.moduleCollectionView.dataSource = self
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //UICollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.moduleCollectionView.dequeueReusableCellWithReuseIdentifier("ModuleCell", forIndexPath: indexPath) as! ModuleCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! ModuleCellModel
        
        
        let imgUrl = model.icon.host + model.icon.dir + model.icon.filepath + model.icon.filename
        
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: imgUrl))
        
        cell.titleLabel.text = model.name
        
        cell.titleLabel.font = UIFont.boldSystemFontOfSize(11)
        
        return cell
        
    }
    
    
}
