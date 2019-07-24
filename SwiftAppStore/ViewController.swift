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
        RONetCenter.requestForHome().mapModelArray(type: Product.self).subscribe(onNext: { (data) in

        }, onError: { (error) in

        }, onCompleted: {

        }, onDisposed: nil).disposed(by: disposeBag)
    
    }


}

