//
//  UIBarButtonExtension.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    public class func creatDefaultLeftBarItemWithTarget(target:Any,action:Selector,portrait:Bool) -> UIBarButtonItem {
    
        let button = UIButton(type: .custom)
    
       
        button.contentMode = .scaleAspectFill;
        let path1 = Bundle(for: MCTabbarController.classForCoder())
    
        let image = UIImage.init(named: "MCreturn", in: path1, compatibleWith: nil)
        button.setImage( image, for:.normal)
        if portrait {
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            button.imageEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 33)
        } else {
            if let window = UIApplication.shared.keyWindow{
                if #available(iOS 11.0, *) {
                    if window.safeAreaInsets.bottom > 0 {
                        // iphoneX 横屏状态下navebar 高度 32
                        button.frame = CGRect(x: 0, y: 0, width: 44, height: 32)
                        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 33)
                    }else{
                        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                        button.imageEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 33)
                    }
                } else {
                    button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    button.imageEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 33)
                }
            }
          
        }
    
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    public class func creatDefaultLeftBarItemWithTarget(target:Any,action:Selector,image:UIImage) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.contentMode = .scaleAspectFill;
        button.setImage( image, for:.normal)
       // button.imageEdgeInsets = UIEdgeInsetsMake(13, 0, 13, 33)
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
  
    public  class func creatRightBarItemWithTarget(target:Any,action:Selector,image:UIImage,imageEgd:UIEdgeInsets) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.contentMode = .scaleAspectFill;
     //   let path1 = Bundle(for: MCTabbarController.classForCoder())
        
      //  let image = UIImage.init(named: "MCreturn", in: path1, compatibleWith: nil)
        button.setImage( image, for:.normal)
        button.imageEdgeInsets = imageEgd
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    public  class func creatRightBarItemWithTarget(target:Any,action:Selector,title:String,titleEdg:UIEdgeInsets,titlColor:UIColor,frame:CGRect) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.frame = frame
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(titlColor, for: .normal)
        button.setTitle(title, for: .normal)
     //   button.titleEdgeInsets = imageEgd
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
}
