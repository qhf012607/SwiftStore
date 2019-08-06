//
//  AddressModel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/3.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class AddressModel: NSObject,Codable {
    
    var name = ""
    var tele = ""
    var address = ""
    var defalt = true
    override init() {
        super.init()
    }
    
}
