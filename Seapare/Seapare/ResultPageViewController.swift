//
//  ResultPageViewController.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-10-01.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!

    var cellPhoneSearchResultList:CellPhoneSearchResultsList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get phone list from its tabBarController
        if let t = self.tabBarController as? TabBarController {
            if let phones = t.cellPhoneSearchResultList {
                self.cellPhoneSearchResultList = phones
            } else {
                print("t.cellPhoneSearchResultList is nil")
            }
        } else {
            print("tabBarController is nil")
        }
        /*
        let sframe = scrollView.frame
        scrollView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI_2))
        scrollView.frame = sframe
        let tframe = table.frame
        table.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_2))
        table.frame = tframe
 */
        //table.frame.size = table.contentSize
        
        table.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Table configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellPhoneSearchResultList.phones.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result Table View Cell", for: indexPath as IndexPath) as! ResultTableViewCell
        if indexPath.row == 0 {
            cell.nameCell.text = "name"
            cell.priceCell.text = "price"
            cell.brandCell.text = "brand"
            cell.cameraCell.text = "camera"
            cell.capacityCell.text = "capacity"
            cell.ramCell.text = "ram"
            cell.compareCell.setTitle("compare", for: .normal)
            
        } else if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
        
        } else {
            let phone = cellPhoneSearchResultList.phones[indexPath.row-1]
            cell.nameCell.text = phone.cellphone_name
            cell.brandCell.text = phone.brand_obj.brand_name
            cell.priceCell.text = "\(phone.price!)"
            cell.cameraCell.text = "\(phone.camera_resolution!)"
            cell.capacityCell.text = "\(phone.capacity!)"
            cell.ramCell.text = "\(phone.ram!)"
            cell.compareCell.setTitle("+", for: .normal)
        }
        
        
        print(tableView.contentSize)
        tableView.contentSize = CGSize(width: cell.compareCell.frame.width + cell.compareCell.frame.origin.x,height:tableView.contentSize.height)
        tableView.frame.size = tableView.contentSize
        scrollView.contentSize = tableView.frame.size
        
        return cell
    }

}

