//
//  DetailPageTableViewCell.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-11-27.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class DetailPageTableViewCell:UITableViewCell {
    
    // Mark: properties
    var lLabel:UILabel!
    var rLabel:UILabel!
    
    override func awakeFromNib() {
        lLabel = UILabel()
        rLabel = UILabel()
        
        lLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height)
        rLabel.frame = CGRect(x: lLabel.frame.origin.x + self.frame.width/2, y: 0, width: self.frame.width/2, height: self.frame.height)
        
        lLabel.textAlignment = .center
        rLabel.textAlignment = .center
        
        lLabel.textColor = UIColor.white
        rLabel.textColor = UIColor.white
        
        lLabel.layer.borderWidth = 1
        rLabel.layer.borderWidth = 1
        
        lLabel.layer.borderColor = UIColor.white.cgColor
        rLabel.layer.borderColor = UIColor.white.cgColor
        
        self.addSubview(lLabel)
        self.addSubview(rLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
