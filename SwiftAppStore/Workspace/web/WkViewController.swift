//
//  WkViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/9.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import WebKit
class WkViewController: MCRootViewController {
    let wk = WKWebView()
    var strUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wk)
        self.title = "用户协议"
        wk.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        wk.load(URLRequest(url:  URL(string: strUrl)!))
    }

    override func viewDidAppear(_ animated: Bool) {
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
