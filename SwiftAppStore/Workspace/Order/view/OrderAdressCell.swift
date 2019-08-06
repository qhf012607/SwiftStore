//
//  OrderAdressCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class OrderAdressCell: UITableViewCell {

    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.backgroundColor = viewBackColor
        viewHead.layer.cornerRadius = 5
        self.selectionStyle = .none
    }
    
    func configCell(model:AddressModel) {
        address.text = model.address
        name.text = model.name
        tel.text = model.tele
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
