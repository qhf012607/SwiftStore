//
//  AddressViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/3.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class AddressViewController: MCRootViewController,UITableViewDelegate,UITableViewDataSource {
    var array = [AddressModel]()
    
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
    }
    
    @objc func add()  {
        
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
