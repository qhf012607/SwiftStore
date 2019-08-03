//
//  CateDetailListModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/30.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

struct CateDetailListModel : Codable{
    var productId : String
    var productName : String
    var productPrice1 : String
    var productPrice2 : String
    var productImage : String
    var productCategoryid : String
    var sequence : Int
    var sales : Int
    var collection : Int
    var productStatus : Int
    var hits : Int
    var isFavorite : Int
}
