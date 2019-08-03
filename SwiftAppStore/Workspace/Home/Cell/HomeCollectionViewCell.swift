//
//  HomeCollectionViewCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/26.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coreView: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        coreView.layer.borderWidth = 1
        coreView.layer.borderColor = viewBackColor.cgColor
        coreView.layer.cornerRadius = 3
        button.layer.cornerRadius = 5
        // Initialization code
    }
    func configCell(product:Product)  {
        imageV.kf_loadimageWithUrlString(url: product.productImage)
        price.text = product.productPrice1
        name.text = product.productName
    }
}
