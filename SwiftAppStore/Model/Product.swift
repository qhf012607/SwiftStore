//
//  Product.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/24.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class Product :NSObject,Codable{
    var sales : Float
    var productPrice1 : String
    var productCategoryid : String
    var isFavorite : Int
    var productImage : String
    var collection : Int
    var productPrice2 : String
    var sequence : Int
    var productId : String
    var productStatus : Int
    var hits : Int
    var productName : String
    var buyCount : Int?
  
    
    var price1Num: String {
        let priceOne = productPrice1.replacingOccurrences(of: "￥", with: "")
      //  let new =  Float(priceSen)! - Float(priceOne)!
        
        return priceOne
    }
    var attribute :String?
    
//    override init(){
//
//    }
    
}
