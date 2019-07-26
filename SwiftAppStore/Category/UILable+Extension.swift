//
//  UILable+Extension.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/9.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    public class func createLable(titleColor:UIColor,font:UIFont,corner:CGFloat,backGround:UIColor,aginment:NSTextAlignment) -> UILabel {
        let  lable =  UILabel()
    
        lable.textColor = titleColor
        lable.font = font
        lable.layer.cornerRadius = corner
        lable.backgroundColor = backGround
        lable.textAlignment = aginment
        return lable
    }
}
