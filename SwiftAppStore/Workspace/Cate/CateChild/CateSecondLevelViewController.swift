//
//  CateSecondLevelViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/30.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateSecondLevelViewController: MCRootViewController {
    var array : [Product] = []
    var cateID = ""
 
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.separatorStyle = .none
        table.register(UINib(nibName: "CateSecondLVCell", bundle: nil), forCellReuseIdentifier: "CateSecondCell")
        // Do any additional setup after loading the view.
        RONetCenter.requestForSecondCate(cateId: cateID).mapModelArray(type: Product.self).subscribe(onNext: {[weak self] (data) in
            self?.array = data
            self?.table.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
    }

    
    

}

extension CateSecondLevelViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CateSecondLVCell = tableView.dequeueReusableCell(withIdentifier: "CateSecondCell") as! CateSecondLVCell
        let model = array[indexPath.row]
        cell.configCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = array[indexPath.row]
        let cont = ProductViewController()
        cont.product_id = model.productId
        cont.cate = model
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
