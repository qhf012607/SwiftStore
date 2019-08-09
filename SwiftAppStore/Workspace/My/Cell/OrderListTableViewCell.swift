//
//  OrderListTableViewCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/8.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var sigleListView: UIView!
    @IBOutlet weak var orderNo: UILabel!
    var cancelBlock : (()->())?
    var orderM : OrderDetailModel?
    var disbosBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        listView.backgroundColor = viewBackColor
        viewBack.layer.cornerRadius = 5
        self.backgroundColor = viewBackColor
        cancelBtn.layer.cornerRadius = 15
        cancelBtn.addTarget(self, action: #selector(cancelClick(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    func configCell(order:OrderDetailModel,stateDis:Int)  {
        orderM = order
        if order .state == 1{
            cancelBtn.isHidden = false
        }else{
            cancelBtn.isHidden = true
        }
        listView.removeAllSubview()
        let goods = order.details
        heightConst.constant = CGFloat(70*goods.count)
    
        orderNo.text = "单号：\(order.orderId)"
        totalPrice.text = "共\(goods.count)件商品 合计：￥\(order.totalprice)"
        for index in 0 ..< goods.count {
            let y = CGFloat(70*index)+10
            let single = goods[index]
            let imageV = UIImageView(frame: CGRect(x: 10, y: y, width: 50, height: 50))
            imageV.kf_loadimageWithUrlString(url: single.goodImg)
             listView.addSubview(imageV)
            let labename = UILabel(frame: .zero)
            labename.numberOfLines = 2
            labename.text = single.goodName
            labename.textColor = UIColor.darkText
            labename.font = UIFont.systemFont(ofSize: 13)
            listView.addSubview(labename)
            labename.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(70)
                make.top.equalToSuperview().offset(y)
                make.right.equalToSuperview().offset(-10)
            }
            let disTribut = UILabel(frame: .zero)
            disTribut.text = single.goodAttribute
            disTribut.textColor = UIColor.darkText
             disTribut.font = UIFont.systemFont(ofSize: 12)
            listView.addSubview(disTribut)
            disTribut.snp.makeConstraints { (make) in
                make.left.equalTo(labename.snp.left)
                make.top.equalToSuperview().offset(y+30)
            }
            let count = UILabel(frame: .zero)
            count.text = "x\(single.goodCount)"
            count.textColor = UIColor.darkText
            count.font = UIFont.systemFont(ofSize: 12)
            listView.addSubview(count)
            count.snp.makeConstraints { (make) in
                make.left.equalTo(disTribut.snp.right).offset(5)
                make.top.equalToSuperview().offset(y+30)
            }
            
           
        }
    }
    
    @objc func cancelClick(sender:UIButton)  {
        HudTool.showloding()
        RONetCenter.cancelOrder(orderId: (orderM?.orderId)!).subscribe(onNext: { [weak self](data) in
            HudTool.hiddloading()
            if self!.cancelBlock != nil {
                self!.cancelBlock!()
            }
        }, onError: { (eror) in
             HudTool.hiddloading()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disbosBag)
        
    }
}
