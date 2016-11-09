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
                phone1properties = t.phone1?.values()
            }
            
            if t.phone2 != nil {
                phone2properties = t.phone2?.values()
                
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
        
        let num = getRowNum()
        
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Compare Page View Cell", for: indexPath as IndexPath) as! ComparePageViewCell
        
        let num = getRowNum()
        
        if indexPath.row == num - 1 {
            cell.lLabel.text = ""
            cell.rLabel.text = ""
            return cell
        }
        
        if indexPath.row == 0 {
            
            // delete icon
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "Delete Icon")
            let attachmentString = NSAttributedString(attachment: attachment)
            
            cell.lLabel.attributedText = attachmentString
            cell.rLabel.attributedText = attachmentString
            
            // gesture
            let gestureL = UITapGestureRecognizer(target: self, action: #selector(self.delectLeftPhone(sender:)))
            let gestureR = UITapGestureRecognizer(target: self, action: #selector(self.delectRightPhone(sender:)))
            
            cell.lLabel.isUserInteractionEnabled = true
            cell.rLabel.isUserInteractionEnabled = true
            
            cell.lLabel.addGestureRecognizer(gestureL)
            cell.rLabel.addGestureRecognizer(gestureR)
            
        } else {
            if phone1properties != nil {
                let value = phone1properties[indexPath.row - 1]
                if value is String {
                    cell.lLabel.text = value as? String
                } else {
                    cell.lLabel.text = "\(value)"
                }
            } else {
                cell.lLabel.text = ""
                //print("phone1properties is nil")
            }
            
            if phone2properties != nil {
                let value = phone2properties[indexPath.row - 1]
                if value is String {
                    cell.rLabel.text = value as? String
                } else {
                    cell.rLabel.text = "\(value)"
                }
            } else {
                cell.rLabel.text = ""
                //print("phone2properties is nil")
            }
        }
        
        return cell
    }
    
    // Mark: selector
    func delectLeftPhone (sender:UITapGestureRecognizer){
        phone1properties = nil
        if let t = self.tabBarController as? TabBarController {
            t.phone1 = nil
        } else {
            print("tabBarController is nil")
        }
        table.reloadData()
        
    }
    
    func delectRightPhone (sender:UITapGestureRecognizer){
        phone2properties = nil
        if let t = self.tabBarController as? TabBarController {
            t.phone2 = nil
        } else {
            print("tabBarController is nil")
        }
        table.reloadData()
    }
    
    // Mark: utilities
    func getRowNum () -> Int {
        if let count = phone1properties?.count {
            return count + 2
        }
        
        if let count = phone2properties?.count {
            return count + 2
        }
        return 0
    }
}
