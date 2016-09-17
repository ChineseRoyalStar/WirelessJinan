//
//  ProgrammePlaylistCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class ProgrammePlaylistCell: UITableViewCell {

    @IBOutlet weak var programmeNameLabel: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    
    @IBOutlet weak var playImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
