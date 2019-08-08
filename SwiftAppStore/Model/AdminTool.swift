//
//  AdminTool.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/6.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class AdminTool: NSObject {
    var user:User?{
      return  MCFileManager.readdefaultUserFile().count > 0 ?  MCFileManager.readdefaultUserFile()[0] : nil
    }
    static let share  = AdminTool()
}
