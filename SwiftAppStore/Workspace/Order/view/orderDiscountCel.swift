//
//  orderDiscountCel.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class orderDiscountCel: UITableViewCell {

    @IBOutlet weak var acturlyPay: UILabel!
    @IBOutlet weak var discountLab: UILabel!
    @IBOutlet weak var deliveryAmount: UILabel!
    @IBOutlet weak var totolPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var widthSnp: NSLayoutConstraint!
    var couponsselect : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func config(model:discountModel) {
        acturlyPay.text = model.sholdPay
        discountLab.text = model.price3
        deliveryAmount.text = model.deliverCont
        totolPrice.text = model.price2
        price.text = model.stringDiscaount
    }
    
    @IBAction func selectCouponse(_ sender: Any) {
        if self.couponsselect != nil {
            self.couponsselect!()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
