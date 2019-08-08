
//
//  OrderDetailModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/8.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

struct OrderDetailModel:Codable {
    var orderId : String
    var createUser : String
    var createDate : String
    var totalprice : Float
    var state : Int
    var deliveryAddress : String
    var details : [OrderSigle]
    
}
