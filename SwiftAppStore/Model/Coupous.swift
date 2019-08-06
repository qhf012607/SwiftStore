//
//  Coupous.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/5.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class Coupous : NSObject,Codable {
     var amount : Float
     var lineAmount : Float
     var alreadGet = false
     init(amount: Float, lineAmount: Float, alreadGet: Bool) {
        self.amount = amount
        self.lineAmount = lineAmount
        self.alreadGet = alreadGet
        
    }
    
}
