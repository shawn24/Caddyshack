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
    
    var tabBar:TabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar = self.tabBarController as! TabBarController
        
        table.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    // MARK: Table configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tabBar.cellPhoneSearchResultList == nil {
            return 0
        }
        
        return tabBar.cellPhoneSearchResultList!.phones.count + 2
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
            let phone = tabBar.cellPhoneSearchResultList!.phones[indexPath.row-1]
            cell.nameCell.text = phone.cellphone_name
            cell.brandCell.text = phone.brand_obj.brand_name
            cell.priceCell.text = "\(phone.price!)"
            cell.cameraCell.text = "\(phone.camera_resolution!)"
            cell.capacityCell.text = "\(phone.capacity!)"
            cell.ramCell.text = "\(phone.ram!)"
            cell.compareCell.setTitle("+", for: .normal)
            cell.compareCell.addTarget(self, action: #selector(self.addToCompareList(sender:)), for: .touchUpInside)
            
        }
        
        
        //print(tableView.contentSize)
        tableView.contentSize = CGSize(width: cell.compareCell.frame.width + cell.compareCell.frame.origin.x,height:tableView.contentSize.height)
        tableView.frame.size = tableView.contentSize
        scrollView.contentSize = tableView.frame.size
        
        return cell
    }
    
    // Mark: Selector
    func addToCompareList(sender:UIButton!){
        if let cell = sender.superview as? ResultTableViewCell {
            let index = (table.indexPath(for: cell)?.row)! - 1
            if let t = self.tabBarController as? TabBarController {
                if t.phone1 == nil {
                    t.phone1 = t.cellPhoneSearchResultList?.phones[index]
                    alert("Add \(t.phone1!.cellphone_name!) to the compare list", nil)
                    
                } else if t.phone2 == nil {
                    t.phone2 = t.cellPhoneSearchResultList?.phones[index]
                    alert("Add \(t.phone2!.cellphone_name!) to the compare list", nil)
                } else {
                    alert("Your compare List is full", nil)
                    
                }
            } else {
                print("tabBarController is nil")
            }

        } else {
            print("Cannot find the cell")
        }
    }
    
    // Mark: alert function
    func alert(_ title:String?,_ message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}

