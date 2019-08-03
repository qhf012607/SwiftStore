
//
//  CateRightTableCell.swift
//  SwiftAppStore
//
//  Created by rhonin on 2019/7/29.
//  Copyright © 2019年 rhonin. All rights reserved.
//

import UIKit

class CateRightTableCell: UITableViewCell {

    @IBOutlet weak var viewImgLieft: UIView!

    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var imageleft: UIImageView!
    @IBOutlet weak var viewImgRight: UIView!
    @IBOutlet weak var imageRight: UIImageView!
    
    @IBOutlet weak var labRight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewImgRight.layer.cornerRadius = 5
        viewImgLieft.layer.cornerRadius = 5
        viewImgRight.layer.borderWidth = 1
        viewImgLieft.layer.borderWidth = 1
        viewImgRight.layer.borderColor = viewLineColor.cgColor
        viewImgLieft.layer.borderColor = viewLineColor.cgColor
        self.selectionStyle = .none
    }
    
    func configCell(model:CateChildModel,index:NSInteger)  {
        if index%2  == 0{
            self.contentView.bringSubviewToFront(viewImgRight)
        }else{
            self.contentView.bringSubviewToFront(viewImgLieft)
        }
        self.imageleft.kf_loadimageWithUrlString(url: model.image)
        self.labelLeft.text = model.name
        self.imageRight.kf_loadimageWithUrlString(url: model.image)
        self.labRight.text = model.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
