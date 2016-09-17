//
//  ProgrammeCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ProgrammeCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var channelLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var programmeNameLabel: UILabel!
    
    @IBOutlet weak var playIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
