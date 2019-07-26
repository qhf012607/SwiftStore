//
//  UIImageViewExt.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/26.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView{
    func kf_loadimageWithUrlString(url:String)  {
        let urlString = URL(string: url)
        self.kf.setImage(with: urlString)
    }
}
