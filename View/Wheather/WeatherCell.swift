//
//  weatherCell.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/10.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
