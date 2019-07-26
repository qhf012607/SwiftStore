//
//  String+ExtenSion.swift
//  MCComon
//
//  Created by sabrina on 2018/1/18.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit
extension String{
    public func getStringHeight(width:CGFloat,font:UIFont) -> CGFloat {
        let string = NSString(string: self)
        let dic = [NSAttributedString.Key.font:font]
        let rect = string.boundingRect(with:  CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options:[ .usesLineFragmentOrigin,.usesFontLeading], attributes: dic, context: nil)
       
        return rect.height
    }
    
}
