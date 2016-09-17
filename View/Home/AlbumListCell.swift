//
//  AlbumListCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {

    @IBOutlet weak var picImageView: UIImageView!
    
    @IBOutlet weak var briefDecLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
