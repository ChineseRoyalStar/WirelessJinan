//
//  UITools.swift
//  WirelessJinan
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 com.ijinan.jinantv. All rights reserved.
//

import Foundation


class UITools {
    
    class func navTitleLabel(title: String) -> UILabel{
        
        let label = UILabel.init(frame: CGRectMake(0, 0, 100, 44))
        
        label.textAlignment = NSTextAlignment.Center
        
        label.textColor = UIColor.init(red: CGFloat(30)/255, green: CGFloat(144)/255, blue:  1, alpha: 1)
        
        label.text = title
        
        label.font = UIFont.boldSystemFontOfSize(18)
        
        label.tag = 100
        
        return label
    }
    
    
    class func newsDetailWithTextFont(size:CGFloat) -> UIFont {
        
        return UIFont.boldSystemFontOfSize(size)
        
    }
    
    class func attributedStringWithLineSpace(str:String,sizeOfFont:CGFloat,lineSpace:CGFloat) -> NSAttributedString {
        
        let attributedStr = NSMutableAttributedString.init(string: str)
        
        let paraStyle = NSMutableParagraphStyle.init()
        
        paraStyle.lineSpacing = lineSpace
        
        attributedStr.addAttributes([NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:UIFont.boldSystemFontOfSize(sizeOfFont)], range: NSRange.init(location: 0, length: str.characters.count))
     
        return attributedStr
    }
    
}