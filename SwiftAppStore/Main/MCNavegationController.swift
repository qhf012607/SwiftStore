//
//  MCNavegationController.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import UIKit
public enum NavegationOrientation {
    case NavegationOrientationHorizontal   //横屏
    case NavegationOrientationVertical   //竖屏
}

open class MCNavegationController: UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    var _enablePopGesture = false
    var didLoad = false
    public var orientation =  NavegationOrientation.NavegationOrientationVertical
    public var navImage = ""
    override open func viewDidLoad() {
        super.viewDidLoad()
        
         weak var weakSelf = self
        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.delegate = weakSelf
        self.delegate = weakSelf
      //  self.navigationBar.barTintColor = UIColor.green
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.GetHexColor(rgbValue: 0xffffff)]
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didLoad {
            //渐变色！
            let path1 = Bundle(for: self.classForCoder)
            let image = UIImage.init(named: navImage.count > 0 ? navImage :"navBarColor", in: path1, compatibleWith: nil)

            self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            didLoad = true
        }
        
    }
    open func pushViewController(viewController:UIViewController,animated:Bool,enablePopGesture:Bool) -> Void {
        _enablePopGesture = enablePopGesture
        if self.viewControllers.count > 0 {
            let portrait = orientation == .NavegationOrientationVertical ? true : false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.creatDefaultLeftBarItemWithTarget(target: self, action: #selector(popSelf),portrait:portrait)
        }
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hiddenNav {
            self.setNavigationBarHidden(true, animated: true)
        }else{
            self.setNavigationBarHidden(false, animated: false)
        }
    }
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if (self.responds(to: #selector(getter:interactivePopGestureRecognizer)) && _enablePopGesture) {
            self.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
       
        self.pushViewController(viewController: viewController, animated: animated, enablePopGesture: true)
        
    }
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        _enablePopGesture = true
        if (self.responds(to: #selector(getter:interactivePopGestureRecognizer)) && animated) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        _enablePopGesture = true
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if (self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0]){
                return false
            }
        }
        return true
    }
    
   public func enableGestureRecognizer(enable:Bool)  {
        if enable {
            if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
                weak var weakSelf = self
                self.interactivePopGestureRecognizer?.delegate = weakSelf
                self.interactivePopGestureRecognizer?.isEnabled = true
                _enablePopGesture = true
                
            }
        }else{
            _enablePopGesture = false
             self.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    open override func popViewController(animated: Bool) -> UIViewController? {
        if (self.topViewController != nil && (self.topViewController?.responds(to: #selector(willPopSelf)))!) {
            self.topViewController?.willPopSelf()
        }
        return super.popViewController(animated: animated)
    }
    
    @objc func popSelf(){
       let _ = self.popViewController(animated: true)
    }
//    override open var shouldAutorotate: Bool{
//        return false
//    }
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        switch orientation {
        case .NavegationOrientationHorizontal:
             return .landscapeRight
        default:
            return .portrait
        }
       
    }
   
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        switch orientation {
        case .NavegationOrientationHorizontal:
            return .landscapeRight
        default:
            return .portrait
        }
    }
}

