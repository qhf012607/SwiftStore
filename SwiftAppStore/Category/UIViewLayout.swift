//
//  UIViewLayout.swift
//  HFPhotoBrowser
//
//  Created by qhf on 2017/11/29.
//  Copyright © 2017年 qhf. All rights reserved.
//

import UIKit

extension UIView{
   public var width:CGFloat{
        set{
            self.frame.size.width = newValue
            
        }
        get{
            return self.frame.size.width
        }
    }
   public var left:CGFloat{
        set{
            self.frame.origin.x = newValue
        }
        get{
            return self.frame.origin.x
        }
    }
    public var right:CGFloat{
        set{
            self.frame.origin.x = newValue - self.frame.size.width
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
   public var top:CGFloat{
        set{
            self.frame.origin.y = newValue
        }
        get{
            return self.frame.origin.y
        }
    }
    public var bottom:CGFloat{
        set{
            var rect = frame
            rect.origin.y = newValue - rect.size.height
            self.frame = rect
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
   public var height:CGFloat{
        set{
            self.frame.size.height = newValue
        }
        get{
            return self.frame.size.height
        }
    }
    /// centerX
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    public func addlineLayer(rect:CGRect,color:UIColor) {
        let layersub = CALayer()
        layersub.frame = rect
        layersub.backgroundColor = color.cgColor
        self.layer.addSublayer(layersub)
    }
   public  func addDashLineLayer(startPoint:CGPoint,endPoint:CGPoint,color:UIColor,linewidth:CGFloat) {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let layersub = CAShapeLayer()
        layersub.lineWidth = linewidth
        layersub.strokeColor = color.cgColor
        layersub.fillColor = UIColor.clear.cgColor
        layersub.lineDashPattern = [8,2]
        layersub.path = linePath.cgPath
        self.layer.addSublayer(layersub)
        
    }
}
