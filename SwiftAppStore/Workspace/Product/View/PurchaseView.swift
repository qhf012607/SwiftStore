//
//  PurchaseView.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/1.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PurchaseView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    var clickBlcik : ((NSInteger,NSInteger)->())?
    
    let viewHead = UIView()
    let viewBack = UIView()
    let table = UITableView(frame: .zero, style: UITableView.Style.plain)
    let viewFoot = UIView()
    var arrayData = [String]()
    let sureBtn = UIButton(frame: .zero)
    let labCount = UILabel()
    let labeName = UILabel()
    let buttonLeft = UIButton()
    let buttonRight = UIButton()
    let labNum = UILabel()
    let subject = BehaviorRelay<String>(value: "1")
    let bag = DisposeBag()
    var selecIndex = 100
    
    var number: NSInteger {
        set{
            if newValue > 0 {
                 subject.accept("\(newValue)")
            }
        }
        get{
            return  Int(subject.value)!
           
        }
    }
   
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        subView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subView() {
        self.addSubview(viewBack)
        self.addSubview(viewHead)
        self.addSubview(table)
        self.addSubview(viewFoot)
        viewFoot.addSubview(sureBtn)
        viewFoot.addSubview(buttonLeft)
        viewFoot.addSubview(buttonRight)
        viewFoot.addSubview(labNum)
        viewFoot.addSubview(labCount)
        buttonLeft.setBackgroundImage(UIImage(named: "reduce"), for: .normal)
        buttonLeft.addTarget(self, action: #selector(reduce), for: .touchUpInside)
        buttonRight.setBackgroundImage(UIImage(named: "add"), for: .normal)
        buttonRight.addTarget(self, action: #selector(add), for: .touchUpInside)
        buttonRight.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(5)
            make.width.height.equalTo(30)
        }
        labNum.snp.makeConstraints { (make) in
            make.right.equalTo(buttonRight.snp.left)
            make.top.equalTo(buttonRight.snp.top)
            make.width.height.equalTo(buttonRight)
        }
        labNum.textAlignment = .center
        buttonLeft.snp.makeConstraints { (make) in
            make.right.equalTo(labNum.snp.left)
            make.height.width.equalTo(30)
            make.top.equalTo(5)
        }
        sureBtn.setTitle("确定", for: .normal)
        
        subject.bind(to: labNum.rx.text).disposed(by: bag)
        self.viewFoot.addSubview(labCount)
        self.labCount.text = "购买数量"
        viewBack.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        viewBack.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        viewHead.snp.makeConstraints { (make) in
            make.bottom.equalTo(260)
            make.left.right.equalTo(0)
            make.height.equalTo(80)
        }
        labCount.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(5)
            make.height.equalTo(30)
        }
        labCount.textColor = UIColor.darkText
        labCount.font = UIFont.systemFont(ofSize: 13)
        viewFoot.snp.makeConstraints { (make) in
            make.top.equalTo(screenHeight-110)
            make.height.equalTo(110)
            make.left.right.equalTo(0)
        }
        viewFoot.backgroundColor = UIColor.white
        sureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(55)
            make.height.equalTo(40)
        }
        sureBtn.addTarget(self, action: #selector(sureButtonclick), for: .touchUpInside)
        sureBtn.layer.cornerRadius = 20
        sureBtn.backgroundColor = UIColor.init(red: 0, green: 160/255.0, blue: 255/255.0, alpha: 1)
        table.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(200)
            make.bottom.equalTo(viewFoot.snp.top)
        }
        table.delegate = self
        table.dataSource = self
      //  self.table.separatorStyle = .none
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hiddenSelf()
       
    }
    
    func hiddenSelf()  {
        UIView.animate(withDuration: 0.5, animations: {
            self.snp.updateConstraints({ (make) in
                make.top.equalTo(screenHeight)
            })
        }) { (k) in
            self.removeFromSuperview()
        }
    }
    @objc func add() {
        number += 1
    }
    
    @objc func reduce() {
       number -= 1
    }
    
    @objc func  sureButtonclick(){
        if selecIndex == 100 || arrayData.count == 0{
            HudTool.showflashMessage(message: "请选择规格")
        }else{
            if (self.clickBlcik != nil){
                self.clickBlcik!(selecIndex,number)
            }
            hiddenSelf()
        }
    }
    
    func reloadTable(array:[String],surBtnClick:@escaping (NSInteger,NSInteger)->()) {
        self.arrayData = array

        self.table.reloadData()
        clickBlcik = surBtnClick
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "productSet")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "productSet")
        }
        cell?.textLabel?.text = arrayData[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecIndex = indexPath.row
    }

}
