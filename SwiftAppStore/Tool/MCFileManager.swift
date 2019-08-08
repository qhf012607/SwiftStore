//
//  MCFileManager.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/5.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class MCFileManager: NSObject {
    
    class func collectProductToLocal(model:Product){
        MCFileManager.writeModelToPath(path: "products.plist", model: model)
    }
    
    class func readcollectsProducts()->[Product]{
       return MCFileManager.readArrayFromPath(path: "products.plist")
    }
    
    class func collectDefaultArrayProduct(array:[Product]){
        MCFileManager.resetArray(array: array, path: "products.plist")
    }
    
    
    
    class func clearUserInfo(){
        MCFileManager.resetArray(array: [User](), path: "User.plist")
    }
    
    class func saveDefaultArrayUser(array:[User]){
        MCFileManager.resetArray(array: array, path: "User.plist")
    }
    
    class func readdefaultUserFile()  -> [User]{
       return MCFileManager.readArrayFromPath(path: "User.plist")
    }
    
    
    
    class func saveTodefaultAddressFile(model:AddressModel) {
        MCFileManager.writeModelToPath(path: "address.plist", model: model)
    }
    
    
    
    class func readAddressData() -> [AddressModel] {
        return MCFileManager.readArrayFromPath(path: "address.plist")
    }
    
    class func updateAddress(array:[AddressModel]){
        MCFileManager.resetArray(array: array, path: "address.plist")
    }
    
    class func saveDefaultCoupon(model:Coupous){
        MCFileManager.writeModelToPath(path: "coupons.plist", model: model)
    }
    
    class func readDefaultCoupon() -> [Coupous]{
        return MCFileManager.readArrayFromPath(path: "coupons.plist")
    }
    
    class func saveDefaultArrayCoupon(array:[Coupous]){
        MCFileManager.resetArray(array: array, path: "coupons.plist")
    }
    
    class func writeModelToPath<T>(path:String,model:T) where T:Codable{
        do {
            let docUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let filePath = docUrl.appendingPathComponent(path)
            
            let exist =   FileManager.default.fileExists(atPath: filePath.path)
          
            var addressArray = [T]()
            
            if exist {
                let contents = try Data(contentsOf: filePath)
                addressArray = try PropertyListDecoder().decode([T].self, from: contents)
                
            }
            addressArray.append(model)
            let encodedPerson = try PropertyListEncoder().encode(addressArray)
            
            try encodedPerson.write(to: filePath, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    class func readArrayFromPath<T>(path:String)->([T]) where T: Codable {
        do {
            let docUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let filePath = docUrl.appendingPathComponent(path)
            
            
            let contents = try Data(contentsOf: filePath)
            let addressArray = try PropertyListDecoder().decode([T].self, from: contents)
            return addressArray
        } catch  {
            print(error)
        }
        return [T]()
    }
    //将数组存入plist
    
    class func resetArray<T>(array:[T],path:String) where T:Codable{
        do {
            let docUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let filePath = docUrl.appendingPathComponent(path)
            
            let exist = FileManager.default.fileExists(atPath: filePath.path)
            var addressArray = [T]()
            
            if exist {
                let contents = try Data(contentsOf: filePath)
                addressArray = try PropertyListDecoder().decode([T].self, from: contents)
                
            }
            addressArray = array 
            let encodedPerson = try PropertyListEncoder().encode(addressArray)
            
            try encodedPerson.write(to: filePath, options: .atomic)
        } catch {
            print(error)
        }
    }
}
