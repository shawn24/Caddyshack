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
    
    var nameTapCount = -1
    var priceTapCount = -1
    var brandTapCount = -1
    var cameraTapCount = -1
    var capacityTapCount = -1
    var ramTapCount = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background picture
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
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
        
        return tabBar.cellPhoneSearchResultList!.phones.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result Table View Cell", for: indexPath as IndexPath) as! ResultTableViewCell
        if indexPath.row == 0 {
            
            cell.nameCell.text = "Name"
            cell.priceCell.text = "Price"
            cell.brandCell.text = "Brand"
            cell.cameraCell.text = "Camera (MP)"
            cell.capacityCell.text = "Capacity (GB)"
            cell.ramCell.text = "Ram (MB)"
            cell.compareCell.setTitle("Compare", for: .normal)
            
            if tabBar.search {
                tabBar.search = false
                self.setHeadersCountToNormal()
            } else {
                if nameTapCount == 0 {
                    cell.nameCell.text = "Name ⬇️"
                } else if nameTapCount == 1 {
                    cell.nameCell.text = "Name ⬆️"
                }
                
                if priceTapCount == 0 {
                    cell.priceCell.text = "Price ⬇️"
                } else if priceTapCount == 1 {
                    cell.priceCell.text = "Price ⬆️"
                }
                
                if brandTapCount == 0 {
                    cell.brandCell.text = "Brand ⬇️"
                } else if brandTapCount == 1 {
                    cell.brandCell.text = "Brand ⬆️"
                }
                
                if cameraTapCount == 0 {
                    cell.cameraCell.text = "Camera ⬇️"
                } else if cameraTapCount == 1 {
                    cell.cameraCell.text = "Camera ⬆️"
                }
                
                if capacityTapCount == 0 {
                    cell.capacityCell.text = "Capacity ⬇️"
                } else if capacityTapCount == 1 {
                    cell.capacityCell.text = "Capacity ⬆️"
                }
                
                if ramTapCount == 0 {
                    cell.ramCell.text = "Ram ⬇️"
                } else if ramTapCount == 1 {
                    cell.ramCell.text = "Ram ⬆️"
                }
            }
            
            let nameTap =  UITapGestureRecognizer(target: self, action:#selector(self.nameTap(sender:)))
            let brandTap = UITapGestureRecognizer(target: self, action:#selector(self.brandTap(sender:)))
            let priceTap = UITapGestureRecognizer(target: self, action:#selector(self.priceTap(sender:)))
            let capacityTap = UITapGestureRecognizer(target: self, action:#selector(self.capacityTap(sender:)))
            let ramTap = UITapGestureRecognizer(target: self, action:#selector(self.ramTap(sender:)))
            let cameraTap = UITapGestureRecognizer(target: self, action:#selector(self.cameraTap(sender:)))
            
            cell.nameCell.isUserInteractionEnabled = true
            cell.priceCell.isUserInteractionEnabled = true
            cell.brandCell.isUserInteractionEnabled = true
            cell.cameraCell.isUserInteractionEnabled = true
            cell.capacityCell.isUserInteractionEnabled = true
            cell.ramCell.isUserInteractionEnabled = true
 
            cell.nameCell.addGestureRecognizer(nameTap)
            cell.priceCell.addGestureRecognizer(priceTap)
            cell.brandCell.addGestureRecognizer(brandTap)
            cell.cameraCell.addGestureRecognizer(cameraTap)
            cell.capacityCell.addGestureRecognizer(capacityTap)
            cell.ramCell.addGestureRecognizer(ramTap)
            
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
    
    func nameTap(sender:UITapGestureRecognizer? = nil){
        if nameTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        nameTapCount = (nameTapCount+1)%2
        var phones:[CellPhone]!

        if nameTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByName((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByName((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    func brandTap(sender: UITapGestureRecognizer? = nil){
        if brandTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        brandTapCount = (brandTapCount+1)%2
        var phones:[CellPhone]!
        
        if brandTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByBrand((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByBrand((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    func priceTap(sender: UITapGestureRecognizer? = nil){
        if priceTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        priceTapCount = (priceTapCount+1)%2
        var phones:[CellPhone]!
        
        if priceTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByPrice((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByPrice((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    func capacityTap(sender: UITapGestureRecognizer? = nil){
        if capacityTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        capacityTapCount = (capacityTapCount+1)%2
        var phones:[CellPhone]!
        
        if capacityTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByCapacity((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByCapacity((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    func ramTap(sender: UITapGestureRecognizer? = nil){
        if ramTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        ramTapCount = (ramTapCount+1)%2
        var phones:[CellPhone]!
        
        if ramTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByRam((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByRam((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    func cameraTap(sender: UITapGestureRecognizer? = nil){
        if cameraTapCount == -1 {
            self.setHeadersCountToNormal()
        }
        
        cameraTapCount = (cameraTapCount+1)%2
        var phones:[CellPhone]!
        
        if cameraTapCount == 0 {
            phones = (tabBar.cellPhoneSearchResultList?.sortByCamera((tabBar.cellPhoneSearchResultList?.phones)!))!
        } else {
            phones = (tabBar.cellPhoneSearchResultList?.sortByCamera((tabBar.cellPhoneSearchResultList?.phones)!))!.reversed()
        }
        
        tabBar.cellPhoneSearchResultList?.phones = phones
        table.reloadData()
    }
    
    // Mark: alert function
    func alert(_ title:String?,_ message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Mark: untilities
    func setHeadersCountToNormal(){
        nameTapCount = -1
        priceTapCount = -1
        brandTapCount = -1
        cameraTapCount = -1
        capacityTapCount = -1
        ramTapCount = -1
    }

}

