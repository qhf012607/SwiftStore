
//
//  CateLeftTableViewCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/29.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateLeftTableViewCell: UITableViewCell {

    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectView.layer.cornerRadius = 5;
         self.selectionStyle = .none
    }
    
    func config(model:CateModel)  {
        if model.select == true {
            selectView.backgroundColor = UIColor.GetRGBColor(R: 41, G: 145, B: 255)
        }else{
             selectView.backgroundColor = UIColor.white
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
