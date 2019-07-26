//
//  MCColorEXT.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    public class func GetHexColor(rgbValue:Int) -> UIColor {
        let red = ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0
        let green = ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0
        let blue  = ((CGFloat)(rgbValue & 0xFF))/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
