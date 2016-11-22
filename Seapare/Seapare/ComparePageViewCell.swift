//
//  ComparePageViewCell.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-11-08.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class ComparePageViewCell:UITableViewCell {

    // Mark: properties
    var lLabel:UILabel!
    var rLabel:UILabel!
    var hLabel:UILabel!
    
    override func awakeFromNib() {
        hLabel = UILabel()
        lLabel = UILabel()
        rLabel = UILabel()
        
        hLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width/3, height: 50)
        lLabel.frame = CGRect(x: hLabel.frame.origin.x + hLabel.frame.width, y: 0, width: self.frame.width/3, height: 50)
        rLabel.frame = CGRect(x: lLabel.frame.origin.x + lLabel.frame.width, y: 0, width: self.frame.width/3, height: 50)
        
        hLabel.textAlignment = .center
        lLabel.textAlignment = .center
        rLabel.textAlignment = .center
        
        hLabel.textColor = UIColor.white
        lLabel.textColor = UIColor.white
        rLabel.textColor = UIColor.white
        
        self.addSubview(hLabel)
        self.addSubview(lLabel)
        self.addSubview(rLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
