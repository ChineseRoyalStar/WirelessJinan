//
//  CommunityCommentCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class CommunityCommentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var portraitImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var publishTimeLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var markLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var clickNumLabel: UILabel!
    
    @IBOutlet weak var postNumLabel: UILabel!
    
    var dataSource = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.scrollDirection = .Horizontal
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 10
        
       layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.itemSize = CGSizeMake((kSCREEN_W - layout.minimumInteritemSpacing*4)/3,(kSCREEN_W - layout.minimumInteritemSpacing*4)/3)
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.registerNib(UINib.init(nibName: "CommentPicCell", bundle: nil), forCellWithReuseIdentifier: "CommentPicCell")
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- UICollectionView Delegate Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CommentPicCell", forIndexPath: indexPath) as! CommentPicCell
        
        let model = self.dataSource.objectAtIndex(indexPath.row) as! PicModel
        
        let attachedUrl = model.host + model.dir + model.filepath + model.filename
        
        let imageUrl = (attachedUrl as NSString).componentsSeparatedByString("?").first

        cell.picImageView.sd_setImageWithURL(NSURL.init(string: imageUrl!),placeholderImage: UIImage.init(named: "placeholder.jpg"))
    
        return cell
    }
    
    
}
