//
//  HudTool.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import PKHUD
class HudTool: NSObject {
    class func showflashMessage(message:String)  {
      
        HUD.flash(  HUDContentType.label(message),delay:1)
    }
    
    class func showLoadingAutoHiden()  {
        
        HUD.flash(  HUDContentType.labeledProgress(title: "", subtitle: ""),delay:0.5)
    }
    class func showloding(){
        HUD.show( HUDContentType.labeledProgress(title: "", subtitle: ""))
    }
    class func hiddloading() {
        HUD.hide()
    }
    
}
