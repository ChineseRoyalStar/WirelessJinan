//
//  GossipCommentCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class GossipCommentCell: UITableViewCell {

    
    @IBOutlet weak var portraitImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var markLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
