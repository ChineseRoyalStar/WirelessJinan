//
//  CommunityWordCommentCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class CommunityWordCommentCell: UITableViewCell {

    @IBOutlet weak var portraitImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var publishTimeLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var markLabel: UILabel!
    
    @IBOutlet weak var clickNumLabel: UILabel!
    
    @IBOutlet weak var postNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
