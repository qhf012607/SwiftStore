//
//  AddressDetailViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/3.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class AddressDetailViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var addressDetail: UITextView!
    @IBOutlet weak var buttonSelect: UIButton!
    var boolDefalt = true
    
    @IBOutlet weak var areaLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gester = UITapGestureRecognizer(target: self, action: #selector(selectViewClick))
        selectView.addGestureRecognizer(gester)
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        self.buttonSelect.layer.cornerRadius = 15
        self.buttonSelect.backgroundColor = viewBackColor
        self.buttonSelect.tag = 0
    }

    func setDefaultAdress(but:UIButton) {
        if but.tag == 0{
            boolDefalt = false
            but.tag = 1
            but.setImage(nil, for: .normal)
        }else{
            boolDefalt = true
            but.tag = 0
            but.setImage(UIImage(named: "selected"), for: .normal)
        }
        
    }
    @objc func selectViewClick(){
        let addressPicker = EWAddressViewController()
        /*** 可使用这种init方法自定制选中颜色,不填写selectColor默认颜色为UIColor(red: 79/255, green: 176/255, blue: 255/255, alpha: 1),蓝色
         let addressPicker = EWAddressViewController(selectColor: UIColor.yellow)
         */
        // 返回选择数据,地址,省,市,区
        addressPicker.backLocationStringController = { [weak self](address,province,city,area) in
            self!.areaLab.text = address
        }
        self.present(addressPicker, animated: true, completion: nil)
    }
    
    
    
    @objc func save()  {
        if name.text?.count == 0 || tel.text?.count == 0 || addressDetail.text?.count == 0 || areaLab.text?.count == 0 || name.text?.count == 0{
            HudTool.showflashMessage(message: "请填满所有信息")
            return
        }
        if (tel.text?.count)! < 11 {
            HudTool.showflashMessage(message: "请填写11位正确手机号")
            return
        }
        HudTool.showLoadingAutoHiden()
        let model = AddressModel()
        model.name = self.name.text!
        model.address = self.areaLab.text! + self.addressDetail.text!
        model.tele = self.tel.text!
        var array = MCFileManager.readAddressData()
        array.insert(model, at: 0)
        MCFileManager.updateAddress(array: array)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            HudTool.showflashMessage(message: "保存成功")
            self.navigationController?.popViewController(animated: true)
        }
        
       
      
    }
}
