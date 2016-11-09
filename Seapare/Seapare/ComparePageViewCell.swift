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
    
    override func awakeFromNib() {
        lLabel = UILabel()
        rLabel = UILabel()
        
        lLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width/2, height: 50)
        rLabel.frame = CGRect(x: lLabel.frame.origin.x + lLabel.frame.width, y: 0, width: self.frame.width/2, height: 50)
        
        lLabel.textAlignment = .center
        rLabel.textAlignment = .center
        
        self.addSubview(lLabel)
        self.addSubview(rLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
