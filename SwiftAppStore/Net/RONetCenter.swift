//
//  RONetCenter.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/23.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
class RONetCenter: NSObject {
    class func requestForHome() ->  Observable<Any> {
        return RONetTool.rx_postNet(parama: nil, apimethoud: "/sports/openapi/get_hot_product")
    }
    
    class func requestForHomeText() -> Observable<Any> {
        let string = "/agent2/api/agent/agentinfo";
        return RONetTool.rx_getNet(parama: nil, apimethoud: string)
    }
}
