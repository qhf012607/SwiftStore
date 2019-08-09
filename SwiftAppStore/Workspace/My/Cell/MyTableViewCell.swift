//
//  MyTableViewCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/8/7.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var tite: UILabel!
    @IBOutlet weak var imageHead: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func config(dic:[String:String])  {
        imageHead.image = UIImage(named: dic["image"]!) 
        tite.text = dic["title"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
