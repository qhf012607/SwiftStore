
//
//  OrderSigleCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderSigleCell: UITableViewCell {

    @IBOutlet weak var viewHose: UIView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageHead: UIImageView!
    var product : Product?
    
    let subject = BehaviorRelay<String>(value: "1")
    let bag = DisposeBag()
    var number: NSInteger {
        set{
            if newValue > 0 {
                subject.accept("\(newValue)")
            }
        }
        get{
            return  Int(subject.value)!
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subject.bind(to: count.rx.text).disposed(by: bag)
        // Initialization code
        self.backgroundColor = viewBackColor
        viewHose.layer.cornerRadius = 5
    }
    
    func config(model:Product) {
        name.text = model.productName
        price.text = model.productPrice1
        number = model.buyCount ?? 1
        product = model
        name.text = product?.productName
        imageHead.kf_loadimageWithUrlString(url: model.productImage)
    }
    
    @IBAction func reduce(_ sender: Any) {
        number -= 1
        product?.buyCount = number
    }
    
    @IBAction func add(_ sender: Any) {
         number += 1
         product?.buyCount = number
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
