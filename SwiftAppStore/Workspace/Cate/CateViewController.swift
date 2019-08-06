
//
//  CateViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/29.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateViewController: MCRootViewController {
    var arrayLeft : [CateModel] = []
    var selectedIndex = 0
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rightTable: UITableView!
    @IBOutlet weak var leftTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.layer.cornerRadius = 14
        searchBar.clipsToBounds = true
        let searchField:UITextField = searchBar.value(forKey: "searchField") as! UITextField
        searchField.backgroundColor = UIColor.clear
        let lableCate = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 60))
        lableCate.text = "热门分类"
        lableCate.textAlignment = .center
        lableCate.font = UIFont.boldSystemFont(ofSize: 17)
        self.leftTable.tableHeaderView = lableCate
        self.view.backgroundColor = UIColor.white
        self.leftTable.register( UINib(nibName: "CateLeftTableViewCell", bundle: nil), forCellReuseIdentifier: "cateLeft")
        self.leftTable.separatorStyle = .none
        self.rightTable.register(UINib(nibName: "CateRightTableCell", bundle: nil), forCellReuseIdentifier: "cateRight")
        self.rightTable.separatorStyle = .none
        HudTool.showloding()
        RONetCenter.requestForCate().mapModelArray(type: CateModel.self).subscribe(onNext: { [weak self](array) in
            HudTool.hiddloading()
            self?.arrayLeft = array
            for index in  0 ..< (self?.arrayLeft)!.count{
                let model = self?.arrayLeft[index]
                if index == 0{
                    model?.select = true
                }else{
                    model?.select = false
                }
            }
            self?.leftTable.reloadData()
            self?.rightTable.reloadData()
        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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

extension CateViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let vc = CateSecondLevelViewController()
        vc.hiddenNav = false
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CateViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return arrayLeft.count
        }else{
            guard  arrayLeft.count>0 else {
                return 0
            }
            let model = arrayLeft[selectedIndex]
            return model.data.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            for model in self.arrayLeft {
                model.select = false
            }
            selectedIndex = indexPath.row
            let model = self.arrayLeft[indexPath.row]
            model.select =  true
            leftTable.reloadData()
            rightTable.reloadData()
        }else{
            let model = self.arrayLeft[selectedIndex]
            let modelS = model.data[indexPath.row]
            let vc = CateSecondLevelViewController()
            vc.cateID = "\(modelS.id)"
            vc.hiddenNav = false
            vc.title = modelS.name
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell:CateLeftTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cateLeft") as! CateLeftTableViewCell
            let model = arrayLeft[indexPath.row]
            cell.title.text = model.name
            cell.config(model: model)
            return cell
        }else{
            let cell:CateRightTableCell = tableView.dequeueReusableCell(withIdentifier: "cateRight") as! CateRightTableCell
            let model = arrayLeft[selectedIndex]
            let modelRight = model.data[indexPath.row]
            cell.configCell(model: modelRight, index: indexPath.row)
            return cell
        }
    }
    
    
    
}
