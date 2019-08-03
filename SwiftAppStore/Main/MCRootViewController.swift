//
//  MCRootViewController.swift
//  MCGlobeKit
//
//  Created by sabrina on 2018/1/8.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa
import PKHUD

open class MCRootViewController: UIViewController {
    public var dicParam : Dictionary<String, Any>?
    let reloadButton = UIButton()
    var disposeBag = DisposeBag()
    var uiloaded = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.GetHexColor(rgbValue: 0xf4f4f4)
        uiConfig()
    }
    
    
    func uiConfig() {
        view.addSubview(reloadButton)
        reloadButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.center.equalToSuperview()
        }
        view.addSubview(reloadButton)
        reloadButton.isHidden = true;
    }
    
    func showReloadButon(reload:@escaping ()->()) {
        reloadButton.isHidden = false
        view.bringSubviewToFront(reloadButton)
        reloadButton.rx.tap.subscribe(onNext: { [weak self] in
            reload()
            self?.reloadButton.isHidden = true
        }).disposed(by: disposeBag)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
