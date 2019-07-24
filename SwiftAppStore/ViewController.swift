//
//  ViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/22.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
//        RONetCenter.requestForHomeText().mapModelArray(type: Product.self).subscribe(onNext: { (data) in
//
//        }, onError: { (error) in
//            let errror = error as! NSError
//            print(errror.code)
//        }, onCompleted: {
//
//        }, onDisposed: nil).disposed(by: disposeBag)
        RONetCenter.requestForHome().mapModelArray(type: Product.self).subscribe(onNext: { (data) in

        }, onError: { (error) in

        }, onCompleted: {

        }, onDisposed: nil).disposed(by: disposeBag)
    
    }


}

