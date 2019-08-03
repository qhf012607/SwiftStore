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

let server = "http://111.231.65.73:8080"
//数据映射错误
public enum defaultNetError: Error {
    case defaultNetErrorToken
    case defaultNetErrorNormal
}
class RONetTool: NSObject {
   
    
    class  func rx_postNet(parama:[String:Any]?,apimethoud:String,header:[String:String]?) -> Observable<Any> {
        let url = server + apimethoud
        
        return RxAlamofire.requestJSON(.post, url, parameters: parama, encoding: URLEncoding.default, headers:RONetTool.configHeader(parama: header)).flatMapLatest({ (arg) ->  Observable<Any> in
            let (responds, data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if(dic["code"] as! Int == 1){
                    observe.onNext(dic["data"]!)
                }else{
                    observe.onError( NSError(domain: "错误", code: dic["code"] as! Int, userInfo: nil) as Error)
                }
                return Disposables.create()
            })
        } )
    }
    
    
    class func rx_getNet(parama:[String:String]?,apimethoud:String,header:[String:String]?)-> Observable<Any> {
        let url = server + apimethoud
        return RxAlamofire.requestJSON(.get, url, parameters: parama, encoding: URLEncoding.default, headers: RONetTool.configHeader(parama: header)).flatMapLatest({ (arg) ->  Observable<Any>  in
            let (responds, data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if(dic["code"] as! Int == 1){
                    observe.onNext(dic["data"]!)
                }else{
               
                    observe.onError( NSError(domain: "错误", code: dic["code"] as! Int, userInfo: nil) as Error)
                }
                return Disposables.create()
            })
        })
    }
    
    class  func rx_postNetWithJson(parama:[String:Any]?,apimethoud:String) -> Observable<Any> {
        let url = server + apimethoud
        var request = URLRequest(url: URL(string:url)!)
        //Following code to pass post json
        do{
           
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
            
            let jsonData = try JSONSerialization.data(withJSONObject: parama ?? [], options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
             request.httpBody =   jsonString?.data(using: .utf8)
           
          
        }catch{
            
        }
        return  RxAlamofire.request(request as URLRequestConvertible).json().asObservable().flatMapLatest({ (arg) ->  Observable<Any> in
            let (data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if(dic["code"] as! Int == 1){
                    observe.onNext(dic["data"]!)
                }else{
                    observe.onError( NSError(domain: "错误", code: dic["code"] as! Int, userInfo: nil) as Error)
                }
                return Disposables.create()
            })
        } )
    }
    
    
    class func rx_getNetWithJson(parama:[String:String]?,apimethoud:String,header:[String:String]?)-> Observable<Any> {
        let url = server + apimethoud
        return RxAlamofire.requestJSON(.get, url, parameters: parama, encoding: URLEncoding.httpBody, headers: RONetTool.configHeader(parama: header)).flatMapLatest({ (arg) ->  Observable<Any>  in
            let (responds, data) = arg
            let dic = data as! Dictionary<String, Any>
            print("\n \(responds) \n\n \(dic) jsonString\n")
            return Observable.create({ (observe) -> Disposable in
                if(dic["code"] as! Int == 1){
                    observe.onNext(dic["data"]!)
                }else{
                    
                    observe.onError( NSError(domain: "错误", code: dic["code"] as! Int, userInfo: nil) as Error)
                }
                return Disposables.create()
            })
        })
    }
    
    class func configHeader(parama:[String:String]?) -> [String:String]? {
        var dic = Dictionary<String, String>()
        if parama != nil {
            for (key, value) in parama! {
                dic.updateValue(value, forKey: key)
            }
        }
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
            let jsonData = element as! [String:Any]
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            let decoder = JSONDecoder()
            do {
                guard let obj = try? decoder.decode(T.self, from: data ) else{
                     throw RxMapModelError.parsingError
                }
                return obj
            }catch {
                print(error)
            }
            return  T.self as! T
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
            let array:[T]?
            do {
                let dataArray : [T] = try! decoder.decode([T].self, from: data)
               array = dataArray
            }catch {
                print(error)
            }
            return  array ?? [T]()
        })
    }
}

