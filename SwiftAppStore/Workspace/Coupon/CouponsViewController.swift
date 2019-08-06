//
//  CouponsViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/5.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CouponsViewController: MCRootViewController,UITableViewDelegate,UITableViewDataSource {
    
    var array = [Coupous]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "领取优惠券"
        let model1 = Coupous(amount: 1, lineAmount: 19, alreadGet: false)
        MCFileManager.saveDefaultCoupon(model: model1)
        let model2 = Coupous(amount: 5, lineAmount: 59, alreadGet: false)
         MCFileManager.saveDefaultCoupon(model: model2)
        let model3 = Coupous(amount: 10, lineAmount: 99, alreadGet: false)
        MCFileManager.saveDefaultCoupon(model: model3)
        let model4 = Coupous(amount: 30, lineAmount: 299, alreadGet: false)
        MCFileManager.saveDefaultCoupon(model: model4)
        let model5 = Coupous(amount: 100, lineAmount: 999, alreadGet: false)
        MCFileManager.saveDefaultCoupon(model: model5)
        array = MCFileManager.readDefaultCoupon()
        table.register(UINib(nibName: "CouponsCell", bundle: nil), forCellReuseIdentifier: "couponsCell")
        table.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponsCell") as! CouponsCell
        let model = self.array[indexPath.row]
        cell.config(model: model)
        cell.getCoupons = { [weak self] (model) in
            if model.alreadGet {
                HudTool.showflashMessage(message: "已经领取过这张优惠券啦！😁")
                return
            }
            model.alreadGet = true
            HudTool.showflashMessage(message: "领取成功，快去使用吧！😁")
            MCFileManager.saveDefaultArrayCoupon(array: self!.array)
        }
        return cell
    }
    
    

}
