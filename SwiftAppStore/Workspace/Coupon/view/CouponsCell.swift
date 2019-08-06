//
//  CouponsCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/5.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CouponsCell: UITableViewCell {

    var getCoupons : ((Coupous)->())?
    
    @IBOutlet weak var allMount: UILabel!
    @IBOutlet weak var money: UILabel!
    var model : Coupous?
    
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func config(model:Coupous)  {
        self.model = model
        money.text = "\(model.amount)元"
        allMount.text = "满\(model.lineAmount)使用"
    }
    
    func setButtonSelect() {
        btn.setTitle("立即使用", for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func getCoupons(_ sender: Any) {
      
        if self.getCoupons != nil {
            self.getCoupons!(model!)
        }
      
       
    }
}
