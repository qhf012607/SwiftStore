//
//  AddressViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/3.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

 protocol MCaddressSelected : NSObjectProtocol{
    func addressSelect(mode:AddressModel)
}

class AddressViewController: MCRootViewController,UITableViewDelegate,UITableViewDataSource {
    var array = [AddressModel]()
    weak var delegate:MCaddressSelected?
    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "addressCell") as! OrderAdressCell
        let model = array[indexPath.row]
        cell.configCell(model: model)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.register(UINib(nibName: "OrderAdressCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.table.separatorStyle = .none
        self.title = "地址管理"
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HudTool.showLoadingAutoHiden()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.array = MCFileManager.readAddressData()
            self.table.reloadData()
            if self.array.count == 0 {
                self.addEmptyView()
                HudTool.showflashMessage(message: "暂无地址，去添加地址吧~")
            }else{
                self.removeEmpty()
            }
        }
       
    }
    
    @objc func add()  {
        self.navigationController?.pushViewController( AddressDetailViewController(), animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            self.table.reloadData()
            MCFileManager.updateAddress(array: array)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model  = array[indexPath.row]
        self.delegate?.addressSelect(mode: model)
        self.navigationController?.popViewController(animated: true)
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
