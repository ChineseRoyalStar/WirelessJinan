//
//  NewsCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/8.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
