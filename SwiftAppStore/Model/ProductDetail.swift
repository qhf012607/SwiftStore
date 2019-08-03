//
//  ProductDetail.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/31.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

struct ProductDetail:Codable {
    var productId : String
    var productContent : String
    var productImages : String
    var attribute : Dictionary<String, Array<String>>
}
