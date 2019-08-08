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
        return RONetTool.rx_postNet(parama: nil, apimethoud: "/sports/openapi/get_hot_product",header: nil)
    }
    
    class func requestForHomeText() -> Observable<Any> {
        let string = "/agent2/api/agent/agentinfo";
        return RONetTool.rx_getNet(parama: nil, apimethoud: string,header: nil)
    }
    
    class func requestForCate() -> Observable<Any> {
        let string = "/sports/openapi/get_category";
        return RONetTool.rx_postNet(parama: nil, apimethoud: string ,header: nil)
    }
    
    class func requestForSecondCate(cateId:String) -> Observable<Any>  {
       
        let string = "/sports/openapi/get_product_categoryid"
        return RONetTool.rx_postNetWithJson(parama: ["pageno": "1","categoryid":cateId], apimethoud: string)
    }
    
    class func requestForProductDetail(productId:String) -> Observable<Any>  {
        
        let string = "/sports/openapi/get_product_detail"
        return RONetTool.rx_postNetWithJson(parama: ["productid": productId], apimethoud: string)
    }
    
    class func requestPayOrder(order:Dictionary<String, Any>) -> Observable<Any>  {
        
        let string = "/sports/openapi/add_order"
        return RONetTool.rx_postNetWithJson(parama: order, apimethoud: string)
    }
    
    class func requestlogin(dic:[String:String])-> Observable<Any> {
        let string = "/sports/openapi/member_login"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
    
    class func addcarRequest(dic:[String:String])-> Observable<Any> {
        let string = "/sports/openapi/add_to_shoppingcar"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
    
    class func getCarList(dic:[String:String])-> Observable<Any>{
        let string = "/sports/openapi/get_shoppingcar_list"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
    
    class func removeCarGoode(dic:[String:Any])-> Observable<Any>{
         let string = "/sports/openapi/remove_from_shoppingcar"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
    
    class func requestOrderList(state:String)-> Observable<Any>{
        let dic = ["userid":"1001","pageno":"1","state":state]
          let string = "/sports/openapi/get_orders"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
    class func register(dic:[String:Any])-> Observable<Any>{
        let string = "/sports/openapi/member_register"
        return RONetTool.rx_postNetWithJson(parama: dic, apimethoud: string)
    }
}
