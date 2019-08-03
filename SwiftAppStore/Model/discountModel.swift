//
//  discountModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/3.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class discountModel {
    var price1 = "￥0.00"
    var deliverCont = "￥0.00"
    var price2 = "￥0.00"
    var price3: String {
        let priceOne = price1.replacingOccurrences(of: "￥", with: "")
        let priceSen = price2.replacingOccurrences(of: "￥", with: "")
        let new =  Float(priceSen)! - Float(priceOne)!
        
        return "￥\(new)"
    }
    var stringDiscaount = ""
}
