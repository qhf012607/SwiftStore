//
//  AboutUsViewController.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/7.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var imageve: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageve.layer.cornerRadius = 5;
        imageve.clipsToBounds = true
        self.title = "关于我们"
        // Do any additional setup after loading the view.
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
