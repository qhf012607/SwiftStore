//
//  NSStringExt.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import UIKit

public let frameWorkPath = Bundle(for: MCTabbarController.classForCoder())

public let screenWith = UIScreen.main.bounds.size.width

public let screenHeight = UIScreen.main.bounds.size.height

public let NavStatusHeight = 44 + UIApplication.shared.statusBarFrame.size.height

public let statusHeight = UIApplication.shared.statusBarFrame.size.height


public let viewLineColor = UIColor(red: 225/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1)

public let viewBackColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1)

/*
 
        通知
 */

public let TokenInvalidNotification = "TokenInvalidNotification"  //tocken失效通知

public let clearDeskNotification = "clearDeskNotification"  //清理缓存通知
