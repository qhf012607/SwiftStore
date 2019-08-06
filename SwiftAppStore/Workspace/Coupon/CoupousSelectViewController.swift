//
//  CoupousSelectViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/6.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CoupousSelectViewController: MCRootViewController,UITableViewDelegate,UITableViewDataSource {
    
    var array = [Coupous]()
    @IBOutlet weak var table: UITableView!
    var selectedCoupous : ((Coupous)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arrayAll = MCFileManager.readDefaultCoupon()
        for coupou in arrayAll {
            if coupou.alreadGet{
                array.append(coupou)
            }
        }
         table.register(UINib(nibName: "CouponsCell", bundle: nil), forCellReuseIdentifier: "couponsUseCell")
        table.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponsUseCell") as! CouponsCell
        let model = self.array[indexPath.row]
        cell.config(model: model)
        
        cell.getCoupons = { [weak self] (model) in
           
            if ((self?.selectedCoupous) != nil) {
                self?.selectedCoupous!(model)
            }
            self?.navigationController?.popViewController(animated: true)
        }
        cell.setButtonSelect()
        return cell
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
