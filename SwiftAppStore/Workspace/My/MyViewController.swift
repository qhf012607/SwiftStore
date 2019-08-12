//
//  MyViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/25.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit


class MyViewController: MCRootViewController {
    @IBOutlet weak var table: UITableView!
    let headview = UIView(frame: CGRect(x: 0, y: 0, width: screenWith, height: 250))
    let array = [["image":"addressList","title":"地址管理"],["image":"collection","title":"我的收藏"],["image":"coupousList","title":"我的卡券"],["image":"helpList","title":"帮助"],["image":"message","title":"消息"],["image":"react","title":"我的建议"],["image":"setAdmin","title":"设置"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统设置"
        self.table.separatorStyle = .none
        self.table.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "mytableCell")
        self.table.tableHeaderView = self.headview
        
        if AdminTool.share.user == nil {
            self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configHead()
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    func configHead() {
        headview.removeAllSubview()
        let imageV =  UIImageView(frame: CGRect(x: 0, y: 0, width: screenWith, height:  screenWith*128/347))
        imageV.image = UIImage(named: "headback")
        headview.addSubview(imageV)
        
        let imageHead = UIImageView(frame: CGRect(x: 0, y: 20, width: 60, height: 60))
        headview.addSubview(imageHead)
        imageHead.image = UIImage(named: "header")
        imageHead.centerX = screenWith/2
        
        let labName = UILabel(frame: CGRect(x: 0, y: 90, width: screenWith, height: 15))
        labName.text = AdminTool.share.user?.username
        labName.textAlignment = .center
        headview.addSubview(labName)
        
        let labeV =  UILabel(frame: CGRect(x: 0, y: 145, width: screenWith, height: 15))
        labeV.text = "——————    会员中心    ——————"
        labeV.textAlignment = .center
        headview.addSubview(labeV)
        let spaceX = (screenWith - 160)/5
        let array = ["待付款","待发货","待收货","待评价"]
        let arrayString = ["waitPay","sendGood","waitRecieve","waitEstimate"]
        for index in 0 ..< array.count {
            let left = spaceX + CGFloat(index)*(spaceX + 40)
            let button  = UIButton(frame: CGRect(x: left, y: 180, width: 40, height: 40))
            if index >= 2 {
                 button.tag = index+1
            }else{
                button.tag = index
            }
            button.addTarget(self, action: #selector(gotoOrlderList(sender:)), for: .touchUpInside)
            button.setBackgroundImage(UIImage(named: arrayString[index]), for: .normal)
            let titleLab = UILabel(frame: CGRect(x: 0, y: 43, width: 40, height: 15))
            button.addSubview(titleLab)
            titleLab.text = array[index]
            titleLab.textAlignment = .center
            titleLab.font = UIFont.systemFont(ofSize: 13)
            headview.addSubview(button)
        }
    }
    
    @objc func gotoOrlderList(sender:UIButton)  {
        if AdminTool.share.user == nil {
            self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
            return
        }
        let cont = OrderListViewController()
        cont.tag = sender.tag
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
extension MyViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mytableCell") as! MyTableViewCell
        let dic = array[indexPath.row]
        cell.config(dic: dic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:   //地址
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
            self.navigationController?.pushViewController(AddressViewController(), animated: true)
            break
        case 1:    //收藏
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
             self.navigationController?.pushViewController(CollectViewController(), animated: true)
            break
        case 2:   //卡券
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
             self.navigationController?.pushViewController(CoupousSelectViewController(), animated: true)
            break
        case 3:     //帮助
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
             self.navigationController?.pushViewController(AboutUsViewController(), animated: true)
            break
        case 4:   //消息
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
             self.navigationController?.pushViewController(MesssageViewController(), animated: true)
            break
        case 5:   //建议
            if AdminTool.share.user == nil {
                self.present( MCNavegationController(rootViewController: LoginViewController()), animated: true, completion: nil)
                return
            }
             self.navigationController?.pushViewController(SuggestionViewController(), animated: true)
            break
        case 6:   //设置
             self.navigationController?.pushViewController(SyystemViewController(), animated: true)
            break
        default:
            break
        }
    }
    
}
