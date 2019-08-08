//
//  CollectViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/7.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CollectViewController: MCRootViewController {
    var array : [Product] = []
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        array = MCFileManager.readcollectsProducts()
        self.title = "我的收藏"
        if array.count == 0 {
            self.addEmptyView()
            HudTool.showflashMessage(message: "还没有收藏的宝贝哦~")
        }
        
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
extension CollectViewController:UITableViewDelegate,UITableViewDataSource{
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
