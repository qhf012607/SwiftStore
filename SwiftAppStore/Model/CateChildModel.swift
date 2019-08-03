//
//  CateChildModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/29.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

struct CateChildModel:Codable {
    var id : Int
    var name : String
    var parentid : Int
    var type : String
    var sequence : Int?
    var image : String
}
