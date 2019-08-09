//
//  LoginViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/6.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class LoginViewController: MCRootViewController {
    @IBOutlet weak var registBtn: UIButton!
    
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registBtn.layer.cornerRadius = 20
        loginBtn.layer.cornerRadius = 20
        image.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        self.title = "登录"
        viewTwo.layer.cornerRadius = 20
        viewOne.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor.white
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    @objc func cancel()  {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registClick(_ sender: Any) {
        self.navigationController?.pushViewController(RegistViewController(), animated: true)
    }
    @IBAction func loginClick(_ sender: Any) {
        RONetCenter.requestlogin(dic: ["deviceid": ((UIApplication.shared.delegate) as! AppDelegate).deviceid,"md5password":password.text!,"userid":telephone.text!]).mapModel(type: User.self).subscribe(onNext: { [weak self](user) in
            MCFileManager.saveDefaultArrayUser(array: [user])
          
            self!.dismiss(animated: true, completion: nil)
        }, onError: { (eror) in
            
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
