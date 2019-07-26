//
//  UIViewControllerExt.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    private struct AssociatedKeys {
        static var hiddenKey = "UIViewController.hiddenNav"
        static var callBackKey = "UIViewController.callBack"
    }
    @objc open func willPopSelf()  {
        
    }
   open var callBack : ((Dictionary<String, Any>)->())?{
        get{
            //   return objc_getAssociatedObject(self, &AssociatedKeys.hiddenKey) as? Bool
            return objc_getAssociatedObject(self, &AssociatedKeys.callBackKey) as? ((Dictionary<String, Any>)->())
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.callBackKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open var hiddenNav : Bool {
        get{
          //   return objc_getAssociatedObject(self, &AssociatedKeys.hiddenKey) as? Bool
            return objc_getAssociatedObject(self, &AssociatedKeys.hiddenKey) != nil ? objc_getAssociatedObject(self, &AssociatedKeys.hiddenKey) as! Bool : false
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.hiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
