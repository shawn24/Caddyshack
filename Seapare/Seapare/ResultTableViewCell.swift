//
//  TableViewCell.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-10-01.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var nameCell:UILabel!
    var brandCell:UILabel!
    var priceCell:UILabel!
    var capacityCell:UILabel!
    var ramCell:UILabel!
    var cameraCell:UILabel!
    var compareCell:UIButton!
    
    var cellCollection:Array<UIView>!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameCell = UILabel()
        brandCell = UILabel()
        priceCell = UILabel()
        capacityCell = UILabel()
        ramCell = UILabel()
        cameraCell = UILabel()
        compareCell = UIButton(type: .roundedRect)
        
        cellCollection = Array<UIView>()
        
        cellCollection.append(nameCell)
        cellCollection.append(brandCell)
        cellCollection.append(priceCell)
        cellCollection.append(capacityCell)
        cellCollection.append(ramCell)
        cellCollection.append(cameraCell)
        cellCollection.append(compareCell)
        
        var i = 0
        
        for cell in cellCollection {
            if i == 0 {
                cell.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            } else {
                let lastCell = cellCollection[i-1]
                cell.frame = CGRect(x: lastCell.frame.origin.x + lastCell.frame.width, y: 0, width: 100, height: 50)
                
            }
            
            if cell is UILabel {
                let c = cell as! UILabel
                c.textAlignment = .center
            } else if cell is UIButton {
                //let c = cell as! UIButton
            }
            
            cell.layer.borderWidth = 1
            
            self.addSubview(cell)
            
            i = i + 1
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
