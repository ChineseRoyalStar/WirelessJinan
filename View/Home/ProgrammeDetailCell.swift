//
//  ProgrammeDetailCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/9/3.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ProgrammeDetailCell: UITableViewCell {

    @IBOutlet weak var scheduledTimeLabel: UILabel!
    
    @IBOutlet weak var programmeLabel: UILabel!
    
    @IBOutlet weak var isPlayingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
