//
//  OrderViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/2.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class OrderViewController: MCRootViewController {
    var array = [Product]()
    var modelDiscount = discountModel()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.backgroundColor = viewBackColor
        table.separatorStyle = .none
        table.register(UINib(nibName: "OrderSigleCell", bundle: nil), forCellReuseIdentifier: "orderCellMiddle")
        table.register(UINib(nibName: "orderDiscountCel", bundle: nil), forCellReuseIdentifier: "orderCellFoot")
        table.register(UINib(nibName: "OrderAdressCell", bundle: nil), forCellReuseIdentifier: "orderCellHead")
        var price1:Float = 0.00
        var price2:Float = 0.00
        
        for product in array {
            let numberstring = product.productPrice1
            let number = numberstring.replacingOccurrences(of: "￥", with: "")
            price1 += Float(number)!
            
            let numberstring2 = product.productPrice2
            let number2 = numberstring2.replacingOccurrences(of: "￥", with: "")
            price2 += Float(number2)!
        }
        modelDiscount.price1 = "￥\(price1)"
        modelDiscount.price2 = "￥\(price2)"
        modelDiscount.stringDiscaount = "未使用优惠券"
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            
            return cell
        }else if indexPath.section == 1{
            let cell = table.dequeueReusableCell(withIdentifier: "orderCellMiddle") as! OrderSigleCell
            let product = self.array[indexPath.row]
            cell.config(model: product)
            return cell
        }else{
            let cell = table.dequeueReusableCell(withIdentifier: "orderCellFoot") as! orderDiscountCel
            cell.config(model: modelDiscount)
            return cell
        }
    }
    
    
}
