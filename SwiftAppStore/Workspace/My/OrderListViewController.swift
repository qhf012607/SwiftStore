//
//  OrderListViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/8.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class OrderListViewController: MCRootViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var vieahead: UIView!
    var tag = 0
    var array = [OrderDetailModel]()
    var arrayBTn = [UIButton]()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var finished: UIButton!
    @IBOutlet weak var waitEst: UIButton!
    @IBOutlet weak var waitReci: UIButton!
    @IBOutlet weak var canceled: UIButton!
    @IBOutlet weak var waitSend: UIButton!
    @IBOutlet weak var waitPay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.backgroundColor = viewBackColor
        self.title = "我的订单"
        arrayBTn = [waitPay,waitSend,canceled,waitReci,waitEst,finished]
        self.table.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "orderlist")
        request(state: tag)
        changeBtnColor(tag: tag)
        switch tag {
        case 0:
            
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }

    func changeBtnColor(tag:Int) {
        for index  in 0 ..< arrayBTn.count {
            let btn = arrayBTn[index]
            btn.setTitleColor(UIColor.darkText, for: .normal)
            if tag == index{
               
                btn.setTitleColor(UIColor.blue, for: .normal)
            }
        }
    }
    func request(state:Int)  {
        
        RONetCenter.requestOrderList(state: "\(state)").mapModelArray(type: OrderDetailModel.self).subscribe(onNext: { [weak self](data) in
            self!.array = data
            if self!.array.count == 0{
                self!.addEmptyView()
                self!.view.bringSubviewToFront(self!.vieahead)
            }else{
                self!.removeEmpty()
            }
            self!.table.reloadData()
        }, onError: { (eror) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
   
    @IBAction func btnclick(_ sender: UIButton) {
        tag = sender.tag
        request(state: tag)
        changeBtnColor(tag: tag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderlist") as! OrderListTableViewCell
        let model = self.array[indexPath.row]
        cell.configCell(order: model, stateDis: "h")
        return cell
    }
    
}
