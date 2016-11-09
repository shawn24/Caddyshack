//
//  ComparePageViewController.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-10-01.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class ComparePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Mark: properties
    @IBOutlet var table: UITableView!
    
    var phone1:CellPhone?
    var phone2:CellPhone?
    
    var phone1properties:Array<Any>!
    var phone2properties:Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let t = self.tabBarController as? TabBarController {
            if t.phone1 != nil {
                phone1 = t.phone1
                phone1properties = phone1?.values()
            }
            
            if t.phone2 != nil {
                phone2 = t.phone2
                
                phone2properties = phone2?.values()
                
            }
        } else {
            print("tabBarController is nil")
        }
        
        table.reloadData()
    }
    
    // MARK: Table configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if phone1properties == nil {
            return 0
        }
        
        return phone1properties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Compare Page View Cell", for: indexPath as IndexPath) as! ComparePageViewCell
        
        if indexPath.row == phone1properties.count {
            cell.lLabel.text = ""
            cell.rLabel.text = ""
            return cell
        }
        
        if phone1properties != nil {
            let value = phone1properties[indexPath.row]
            if value is String {
                cell.lLabel.text = value as? String
            } else {
                cell.lLabel.text = "\(value)"
            }
        } else {
            print("phone1properties is nil")
        }
        
        if phone2properties != nil {
            let value = phone2properties[indexPath.row]
            if value is String {
                cell.rLabel.text = value as? String
            } else {
                cell.rLabel.text = "\(value)"
            }
        } else {
            print("phone2properties is nil")
        }
        
        return cell
    }

    
}
