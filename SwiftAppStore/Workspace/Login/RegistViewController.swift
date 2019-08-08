//
//  RegistViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/6.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class RegistViewController: MCRootViewController {

    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var tele: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        // Do any additional setup after loading the view.
    }

    @IBAction func xieyi(_ sender: Any) {
    }
    
    @IBAction func register(_ sender: Any) {
        if (tele.text?.count)! < 11 {
            HudTool.showflashMessage(message: "请填写正确手机号")
        }else if ((pass.text?.count)! < 6){
            HudTool.showflashMessage(message: "请填写6-11位密码")
        }else if (pass.text != confirmPass.text){
            HudTool.showflashMessage(message: "两次密码不一致")
        }
        let dic = ["userid":tele.text!,"nickname":tele.text!,"md5password":pass.text!,"deviceid":((UIApplication.shared.delegate) as! AppDelegate).deviceid]
        RONetCenter.register(dic: dic).subscribe(onNext: { [weak self](data) in
            HudTool.showflashMessage(message: "注册成功")
            self?.navigationController?.popViewController(animated: true)
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
