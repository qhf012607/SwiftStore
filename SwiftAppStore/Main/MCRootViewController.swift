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
    let imageEmpty = UIImageView(frame: .zero)
    let lab = UILabel(frame: .zero)
    let emptyView = UIView()
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.GetHexColor(rgbValue: 0xf4f4f4)
        uiConfig()
        NotificationCenter.default.addObserver(self, selector: #selector(loginOut), name: NSNotification.Name(rawValue:TokenInvalidNotification), object: nil)
       
    }
    
    @objc func loginOut() {
        MCFileManager.clearUserInfo()
       
        self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addEmptyView()  {
        view.addSubview(emptyView)
        emptyView.backgroundColor = UIColor.white
        emptyView.addSubview(imageEmpty)
        emptyView.addSubview(lab)
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.imageEmpty.image = UIImage(named: "empty")
        self.imageEmpty.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        self.lab.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageEmpty.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }
        lab.text = "这里空空如也~"
        lab.textAlignment = .center
        lab.font = UIFont.systemFont(ofSize: 14)
    }
    
    func removeEmpty() {
        self.emptyView.removeFromSuperview()
       // lab.removeFromSuperview()
    }
    
    func uiConfig() {
        view.addSubview(reloadButton)
        reloadButton.setTitle("重新加载", for: .normal)
        reloadButton.backgroundColor = UIColor.white
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        reloadButton.setTitleColor(UIColor.black, for: .normal)
        reloadButton.layer.cornerRadius = 20;
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

}
