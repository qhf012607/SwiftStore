//
//  SyystemViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/7.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import Kingfisher
class SyystemViewController: MCRootViewController {

   
    @IBOutlet weak var quitBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "反馈建议"
        ImageCache.default.calculateDiskCacheSize { [weak self](usedDiskCacheSize) in
            self?.clearBtn.setTitle("清理缓存 \(usedDiskCacheSize/(1024*1024))M", for: .normal)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func loginOut(_ sender: Any) {
         MCFileManager.clearUserInfo()
        self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
    }
    
    @IBAction func clearDesk(_ sender: Any) {
        ImageCache.default.clearDiskCache {[weak self] in
            self!.clearBtn.setTitle("清理缓存 0M", for: .normal)
        }
    }
    

}
