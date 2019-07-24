//
//  RONetTool.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/22.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import Alamofire
import SwiftyJSON
import AnyCodable

let server = "http://111.231.65.73:8080"
class RONetTool: NSObject {
   
    
     class  func rx_postNet(parama:[String:String]?,apimethoud:String) -> Observable<Any> {
        let url = server + apimethoud
        
        return RxAlamofire.requestJSON(.post, url, parameters: parama, encoding: URLEncoding.default, headers:RONetTool.configHeader(parama: nil)).flatMapLatest({ (arg) ->  Observable<Any> in
            let (responds, data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if((dic["data"]) != nil){
                    observe.onNext(dic["data"]!)
                }
                return Disposables.create()
            })
        } )
    }
    
    
    class func rx_getNet(parama:[String:String]?,apimethoud:String)-> Observable<Any> {
        let url = server + apimethoud
        return RxAlamofire.requestJSON(.get, url, parameters: parama, encoding: URLEncoding.default, headers: nil).flatMapLatest({ (arg) ->  Observable<Any>  in
            let (responds, data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if((dic["data"]) != nil){
                    observe.onNext(dic["data"]!)
                }
                return Disposables.create()
            })
        })
    }
    
    class func configHeader(parama:[String:String]?) -> [String:String]? {
        var dic = Dictionary<String, String>()
        if parama != nil {
            for (key, value) in parama! {
                dic.updateValue(key, forKey: value)
            }
        }
        dic.updateValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE4NjE1ODFiNGViNTU0YTBhNGQ3MDZjNzZhNWZkYmUyNzlkNzFkZDdlNzFlNTQzOWJjNDMzOTY2NDNkNTdiZDM0Yjc3ZDhkYjViMjZjMzBjIn0.eyJhdWQiOiIxIiwianRpIjoiMTg2MTU4MWI0ZWI1NTRhMGE0ZDcwNmM3NmE1ZmRiZTI3OWQ3MWRkN2U3MWU1NDM5YmM0MzM5NjY0M2Q1N2JkMzRiNzdkOGRiNWIyNmMzMGMiLCJpYXQiOjE1NjAzMjMzOTcsIm5iZiI6MTU2MDMyMzM5NywiZXhwIjoxNTYwMzI1MTk3LCJzdWIiOiIyMDU1OTQyNzgwMjA4ODIwIiwic2NvcGVzIjpbXX0.XGsStEvn6V5EsCCxdJmqm5IX4up8Nq5GUrdW2WdZ12Sp13oFfehI-VCuVgxRaCSBZt9Cu-uoCk8XZEFjlIX4sbYHpYwYmr1bpLTi9uwDFjliAHg9ij71PVwFsvF-HSlhfeUjIm50IZSj3ZfMhLTlYtvvXSTi557tOSaxEM-oYcAX-B0-zqaTmdtjDwbccSICuY8a2tIODNldKN2hY6YhfWF_SOsimkTIVK45ITEPAn_Oa8-gK_jv_i5hhyTJ2eBLxkraqGJpZSvrmGZFROViup12oGzvQbwwdHsoN-wd9jVFvWcekN9_7I0JpcagRqDImarNG1oiSAgtv14glV4qY30aRIiCc8reG0mZKs4dO_kYhGZGXPqIt1So2zxyEsEhOjGhgRzUyiuUMOp0RR73hXW2LgulckGiv14obdraovrlIZIsWZwu3Wg4bclPoLY0wGu2CrF_EfrydaU5wKf0_2KV43dyraZ9AuxKG7omf5kTDTPTkWUXgLbzRGhVgQoLZoXu32Dmr46ZItzDaZzMlMS5l-fUd7vER7rshU-7905fVQmwOmx6K6JRGMITRO3n3iTHwOkZO0WsBoUDP37q5F5PCehapZEWhzCVJ-knfKvnPSth1eGAgIb6gzErjo3rCfAnbOPTBwkPGA6zzukuDa1wOdHklElgdbhccqvOprE", forKey: "Authorization")
        return dic;
    }
}


//数据映射错误
public enum RxMapModelError: Error {
    case parsingError
}

public extension Observable where Element:Any{
    
    
    /// 轉模型
    ///
    /// - Parameter type: json转模型
    /// - Returns: model
    public func mapModel<T>(type:T.Type) -> Observable<T> where T:Codable{
        return self.map({ (element) -> T in
            let jsonData = try (element as! JSON).rawData() 
            let decoder = JSONDecoder()
            do {
                guard let obj = try? decoder.decode(T.self, from: jsonData ) else{
                     throw RxMapModelError.parsingError
                }
                return obj
            }catch {
                print(error)
            }
            return ErrorModel() as! T
        })
    }
    
    /// 轉模型数组
    ///
    /// - Parameter type: json转模型
    /// - Returns: 轉模型数组
    public func mapModelArray<T>(type:T.Type) -> Observable<[T]> where T:Codable{
        return self.map({ (element) -> [T] in
//    
//            let jsonData =  (element as! JSON).arrayValue
          //  let string = element as! String
            let dic = element as! [[String:Any]]
            let data = try JSONSerialization.data(withJSONObject: dic, options: [])
            let decoder = JSONDecoder()
            do {
                guard let dataArray : [T] = try? decoder.decode([T].self, from: data) else {
                    
                    throw RxMapModelError.parsingError
                }
                return dataArray
            }catch {
                print(error)
            }
            return [ErrorModel()] as! [T]
        })
    }
}

