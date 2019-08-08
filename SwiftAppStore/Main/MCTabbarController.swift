//
//  MCTabbarController.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import UIKit

open class MCTabbarController: UITabBarController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        self.setDefault();
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefault() {
        let home = HomeVCViewController()
        home.hiddenNav = true
        self.addChildController(controller: home, title: "推荐", selectedImage: "Recomand", nornalImage: "RecomandUN", tag: 1)
        let cate = CateViewController()
        cate.hiddenNav = true
        self.addChildController(controller:cate , title: "分类", selectedImage: "cate", nornalImage: "cateUN", tag: 1)
        let car = CarViewController()
        car.hiddenNav = false
        self.addChildController(controller: car, title: "购物车", selectedImage: "car", nornalImage: "carUN", tag: 1)
        let my = MyViewController()
        my.hiddenNav = true
        self.addChildController(controller:my , title: "我的", selectedImage: "my", nornalImage: "myUN", tag: 1)
    }
    
    func addChildController(controller:MCRootViewController,title:String,selectedImage:String,nornalImage:String,tag:NSInteger) {
        controller.tabBarItem = self.setupTabBarItem(title: title, selectedImage: selectedImage, normalImage: nornalImage, tag: tag)
        let navigationCont = MCNavegationController(rootViewController: controller)
//        navigationCont.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
     //     controller.hiddenNav = true;
      //  navigationCont.navigationBar.shadowImage = UIImage.imageWithLineColor(color: UIColor.GetHexColor(rgbValue: 0xe5e5e5))
        self.addChild(navigationCont)
    }
    
    func setupTabBarItem(title:String,selectedImage:String,normalImage:String,tag:NSInteger) -> UITabBarItem {

        let tabBarItem = UITabBarItem(title: title, image: (UIImage.init(named: normalImage))!.withRenderingMode(.alwaysOriginal), selectedImage: (UIImage.init(named: selectedImage))!.withRenderingMode(.alwaysOriginal))
        
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.GetHexColor(rgbValue: 0x666666),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9)], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.GetHexColor(rgbValue: 0x1296db),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9)], for: .selected)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -3.0);
        tabBarItem.tag = tag
        return tabBarItem
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.selectedIndex = item.tag
    }
    override open var shouldAutorotate: Bool{
        return false
    }
//    override open var shouldAutorotate: Bool{
//        return true
//    }
////    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
////        return .portrait
////    }
//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return [.portrait  ,.landscapeRight ]
//    }

}

extension UIImage{
    class func imageWithLineColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
