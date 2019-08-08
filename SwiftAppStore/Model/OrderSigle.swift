//
//  OrderSigle.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/8.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

struct OrderSigle:Codable {
    var orderId : String
    var goodId : String
    var goodAttribute : String
    var goodName : String
    var goodImg : String
    var goodCount : Int
    var goodPirce : Float
}
