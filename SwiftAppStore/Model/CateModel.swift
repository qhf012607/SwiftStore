//
//  CateModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/29.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateModel:Codable {
    var id : Int
    var name : String
    var parentid : Int
    var type : String
    var data : Array<CateChildModel>
    var select : Bool?
    
}
