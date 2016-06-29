//
//  LeftTableViewCell.swift
//  ZhiHuNews
//
//  Created by 左梓豪 on 16/4/26.
//  Copyright © 2016年 左梓豪. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.init(red: 50/255.0, green: 50/255.0, blue: 60/255.0, alpha: 1)
        cellLabel.textColor = UIColor.lightGrayColor()
        cellLabel.font = UIFont.systemFontOfSize(14)
//         Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
