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
    
    var headersArray:Array<String>!
    var phone1properties:Array<Any>!
    var phone2properties:Array<Any>!
    var tabBarController_m:TabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background picture
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        
        headersArray = CellPhone().properties()
        
        tabBarController_m = self.tabBarController as! TabBarController
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
        tabBarController_m = self.tabBarController as! TabBarController
        
    }
    
    // MARK: Table configurations
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let num = headersArray.count
        
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Compare Page View Cell", for: indexPath as IndexPath) as! ComparePageViewCell
        
        let num = headersArray.count
        
        if indexPath.row == num - 1 {
            cell.hLabel.text = ""
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
            
            cell.hLabel.text = ""
            
        } else {
            cell.hLabel.text = headersArray[indexPath.row - 1]
            
            if phone1properties != nil {
                let value:Any? = phone1properties[indexPath.row - 1]
                if value is String {
                    cell.lLabel.text = value as? String
                } else {
                    cell.lLabel.text = "\(value!)"
                }
                
                if cell.lLabel.text == "nil" {
                    cell.lLabel.text = "N/A"
                }
            } else {
                cell.lLabel.text = ""
            }
            
            if phone2properties != nil {
                let value:Any? = phone2properties[indexPath.row - 1]
                
                if value == nil {
                    cell.rLabel.text = "N/A"
                }
                cell.rLabel.text = "\(value!)"
                
                
                if cell.rLabel.text == "nil" {
                    cell.rLabel.text = "N/A"
                }
            } else {
                cell.rLabel.text = ""
            }
            
            // reset text color
            cell.lLabel.textColor = UIColor.white
            cell.rLabel.textColor = UIColor.white
            
            // highlight the higher value
            if tabBarController_m.phone1 != nil && tabBarController_m.phone2 != nil {
                switch headersArray[indexPath.row - 1] {
                case "price":
                    if(tabBarController_m.phone1!.comparePrice(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.comparePrice(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break
                case "screen_size":
                    if (tabBarController_m.phone1!.compareScreenSize(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareScreenSize(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break
                case "ppi":
                    if (tabBarController_m.phone1!.comparePPI(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.comparePPI(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }

                    break
                    
                case "resolution":
                    break
                case "ram":
                    if (tabBarController_m.phone1!.compareRam(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareRam(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    
                    break
                
                case "capacity":
                    if (tabBarController_m.phone1!.compareCapacity(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareCapacity(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "device_size":
                    if (tabBarController_m.phone1!.compareDeviceSize(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareDeviceSize(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "camera_resolution":
                    if (tabBarController_m.phone1!.compareCamera(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareCamera(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "warranty":
                    if (tabBarController_m.phone1!.compareWarranty(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareWarranty(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "standby_hour":
                    if (tabBarController_m.phone1!.compareStandby_hour(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareStandby_hour(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "gps_flag":
                    if (tabBarController_m.phone1!.compareGPS(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareGPS(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "bluetooth_flag":
                    if (tabBarController_m.phone1!.compareBluetooth(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareBluetooth(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "nfc_flag":
                    if (tabBarController_m.phone1!.compareNFC(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareNFC(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "memory_card_support_flag":
                    if (tabBarController_m.phone1!.compareMemoryCardSupport(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareMemoryCardSupport(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                case "fingerprint_flag":
                    if (tabBarController_m.phone1!.compareFingerprint(c: tabBarController_m.phone2!)>0) {
                        cell.lLabel.textColor = UIColor.red
                    } else if (tabBarController_m.phone1!.compareFingerprint(c: tabBarController_m.phone2!)<0) {
                        cell.rLabel.textColor = UIColor.red
                    }
                    break;
                    
                default:
                    break
                }
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
