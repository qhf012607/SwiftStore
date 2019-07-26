//
//  TableView+ExtenSion.swift
//  MCComon
//
//  Created by sabrina on 2018/1/19.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit
extension UIScrollView{
    private struct AssociatedKeys {
        static var arrayDatakey = "UITableView.arrayData"
    }
    @objc open func willPopSelf()  {
        
    }
    
    open var arrayData : Array<Any>? {
        get{
            //   return objc_getAssociatedObject(self, &AssociatedKeys.hiddenKey) as? Bool
            return  objc_getAssociatedObject(self, &AssociatedKeys.arrayDatakey) as? Array<Any>
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.arrayDatakey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
