//
//  CateSecondLVCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/30.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateSecondLVCell: UITableViewCell {

    @IBOutlet weak var imagehead: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var boughtnm: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var read: UILabel!
    @IBOutlet weak var baoyou: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(model:Product)  {
        boughtnm.text =  "\(model.sales)人购买"
        price.text = model.productPrice1
        name.text = model.productName
        read.text = "\(model.hits)人浏览"
        imagehead.kf_loadimageWithUrlString(url: model.productImage)
        self.selectionStyle = .none
    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
