//
//  OrderViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxCocoa
class OrderViewController: MCRootViewController,MCaddressSelected {
    var array = [Product]()
    var modelDiscount = discountModel()
    var addressmodel : AddressModel?
    var totalCount = 0
    
    @IBOutlet weak var countTotle: UILabel!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submit.layer.cornerRadius = 20
        table.backgroundColor = viewBackColor
        table.separatorStyle = .none
        table.register(UINib(nibName: "OrderSigleCell", bundle: nil), forCellReuseIdentifier: "orderCellMiddle")
        table.register(UINib(nibName: "orderDiscountCel", bundle: nil), forCellReuseIdentifier: "orderCellFoot")
        table.register(UINib(nibName: "OrderAdressCell", bundle: nil), forCellReuseIdentifier: "orderCellHead")
        count()
        self.title = "确认订单"
        submit.addTarget(self, action: #selector(pay(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }


    func count()  {
        var price1:Float = 0.00
        var price2:Float = 0.00
        
        for product in array {
            let numberstring = product.productPrice1
            let number = numberstring.replacingOccurrences(of: "￥", with: "")
            let countNum = product.buyCount ?? 1
            price1 += Float(number)!*Float(countNum)
            
            let numberstring2 = product.productPrice2
            let number2 = numberstring2.replacingOccurrences(of: "￥", with: "")
            price2 += Float(number2)!*Float(countNum)
            totalCount += countNum
        }
        modelDiscount.price1 = "￥\(price1)"
        modelDiscount.price2 = "￥\(price2)"
      
        let arrayAddress = MCFileManager.readAddressData()
        if arrayAddress.count > 0 {
            self.addressmodel = arrayAddress[0]
        }
        let shoudpay =  price1 - Float(modelDiscount.coupousCout)
        modelDiscount.sholdPay = "￥\(shoudpay)"
        self.table.reloadData()
      
        countTotle.text = "共\(totalCount)件，合计： ￥\(shoudpay)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func addressSelect(mode: AddressModel) {
        addressmodel = mode
        self.table.reloadData()
    }
    
    
    @objc func pay(sender:UIButton)  {
        if (AdminTool.share.user?.usercode) == nil {
            self.present(LoginViewController(), animated: true, completion: nil)
        }else
        {
        if addressmodel == nil {
            HudTool.showflashMessage(message: "请选择收获地址~")
            return
        }
        var arrayGoode = [[String:String]]()
        for goode in array {
            let dic = ["good_pirce":goode.price1Num,"good_discount":"0.00","good_attribute":goode.attribute ?? "","good_id":goode.productId,"good_img":goode.productImage,"good_name":goode.productName,"good_count":"\(goode.buyCount!)"]
            arrayGoode.append(dic )
        }
            let dicAll = ["details":arrayGoode,"consignee":AdminTool.share.user?.username ?? "","totaldiscount":"0","createuser":AdminTool.share.user?.usercode ?? "","totalprice":modelDiscount.sholdpayNum,"delivery_address":addressmodel!.address,"consignee_phone":AdminTool.share.user?.usercode ?? ""] as [String : Any]
        RONetCenter.requestPayOrder(order: dicAll).subscribe(onNext: { [weak self](data) in
             self?.showSucess()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        }
    }
    
    func showSucess() {
        let cont = UIAlertController(title: "下单成功", message: "下单成功！本平台仅支持线下货到付款，请耐心等待~", preferredStyle: .alert)
        let act = UIAlertAction(title: "知道了", style: .destructive) { (act) in
            self.navigationController?.popViewController(animated: true)
        }
        cont.addAction(act)
        self.present(cont, animated: true, completion: nil)
    }
}

extension OrderViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && section == 1 {
            return 1
        }else{
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "orderCellHead") as! OrderAdressCell
            if(addressmodel != nil){
                cell.configCell(model: addressmodel!)
            }
            return cell
        }else if indexPath.section == 1{
            let cell = table.dequeueReusableCell(withIdentifier: "orderCellMiddle") as! OrderSigleCell
            let product = self.array[indexPath.row]
            cell.config(model: product)
            cell.countbock = { [weak self] in
                self?.count()
            }
            return cell
        }else{
            let cell = table.dequeueReusableCell(withIdentifier: "orderCellFoot") as! orderDiscountCel
            cell.config(model: modelDiscount)
            cell.couponsselect = { [weak self] in
                    self?.toGetCoupous()
            }
            return cell
        }
    }
    
    func toGetCoupous()  {
        let cont = CoupousSelectViewController()
        cont.selectedCoupous = {[weak self](coupou) in
         
            self!.modelDiscount.coupousCout = Double(coupou.amount)
             self!.modelDiscount.stringDiscaount = "已使用\(self!.modelDiscount.coupousCout)元优惠券"
            self!.count()
        }
        self.navigationController?.pushViewController(cont, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cont = AddressViewController()
            cont.delegate = self
            self.navigationController?.pushViewController(cont, animated: true)
        }else{
            
        }
       
    }
    
    
}
