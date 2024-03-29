//
//  CarViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/25.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CarViewController: MCRootViewController {
    var array = [CarGood]()
    
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var carLab: UILabel!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.table.register(UINib(nibName: "OrderSigleCell", bundle: nil), forCellReuseIdentifier: "carcell")
        self.title = "购物车"
        table.separatorStyle = .none
        table.backgroundColor = viewBackColor
        carBtn.layer.cornerRadius = 10
      
    }
    
    @IBAction func order(_ sender: Any) {
        if AdminTool.share.user == nil {
              self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
          //  HudTool.showflashMessage(message: "请先登录")
            return
        }
        var arrayNew = [Product]()
        
        var dic = [String:Any]()
        for goode in array {
            dic["productId"] = goode.goodId
            dic["attribute"] = goode.goodAttribute
            dic["productCategoryid"] = ""
            dic["isFavorite"] = 0
            dic["productImage"] = goode.goodImg
            dic["collection"] = 0
            dic["productPrice2"] = ""
            dic["sequence"] = 0
            dic["productStatus"] = 0
            dic["hits"] = 0
            dic["productName"] = goode.goodName
            dic["buyCount"] = goode.goodCount
            dic["sales"] = 0.0
            dic["productPrice1"] = "\(goode.goodPirce)"
            dic["productPrice2"] = "\(goode.goodPirce+goode.discount)"
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: [])
                let decoder = JSONDecoder()
                let product =  try decoder.decode(Product.self, from: data)
                arrayNew.append(product)
            }catch {
                print(error)
            }
         //   mode
        }
        let cont = OrderViewController()
        cont.array = arrayNew
        self.navigationController?.pushViewController(cont, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if AdminTool.share.user == nil {
          //  self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
            HudTool.showflashMessage(message: "请先登录")
            return
        }
       self.requestForgood()
    }

    func requestForgood()  {
        let dic = ["userid":"1001","deviceid":((UIApplication.shared.delegate) as! AppDelegate).deviceid,"pageno":"1","secretkey":AdminTool.share.user!.secretkey]
        RONetCenter.getCarList(dic: dic).mapModelArray(type: CarGood.self).subscribe(onNext: { [weak self](cargoods) in
            HudTool.hiddloading()
            self!.array = cargoods
            if self!.array.count == 0{
                self!.addEmptyView()
            }else{
                self!.removeEmpty()
            }
            self?.count()
            self!.table.reloadData()
            }, onError: { (error) in
                 HudTool.hiddloading()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func count()  {
        var price1:Float = 0.00
        for product in array {
            let numberstring = product.goodPirce
         //   let number = numberstring.replacingOccurrences(of: "￥", with: "")
            let countNum = product.goodCount
            price1 += numberstring * Float(countNum)
            
        }
        self.table.reloadData()
        self.carLab.text = "合计： ￥\(price1)"
    }
}
extension CarViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carcell")  as! OrderSigleCell
        let model = self.array[indexPath.row]
        cell.configCar(model: model)
        cell.countbock = { [weak self] in
            self?.count()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = self.array[indexPath.row]
            self.removeCarGood(model: car)
        }
    }
    
    func removeCarGood(model:CarGood)  {
        let array = [["productattribute":model.goodAttribute,"userid":"1001","productid":model.goodId]]
        let dic = ["userid":"1001","deviceid":((UIApplication.shared.delegate) as! AppDelegate).deviceid,"list":array,"secretkey":AdminTool.share.user!.secretkey] as [String : Any]
        RONetCenter.removeCarGoode(dic:dic).subscribe(onNext: {[weak self] (data) in
            self!.requestForgood()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
    }
    
}
