//
//  DetailPageViewController.swift
//  Seapare
//
//  Created by Yulun Wu on 2016-11-27.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

class DetailPageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    // properties
    var navController:DetailPageNavController!
    var phoneHeaders:Array<String>?
    var phoneValues:Array<Any>?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set background picture
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        navController = self.navigationController as! DetailPageNavController
        
        
        phoneHeaders = CellPhone().properties()
        if navController.phone != nil {
            phoneValues = navController.phone.values()
        }
        
        
        
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

        if phoneHeaders != nil {
            return phoneHeaders!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail page table view cell", for: indexPath as IndexPath) as! DetailPageTableViewCell
        cell.lLabel.text = phoneHeaders![indexPath.row].replacingOccurrences(of: "_", with: " ").replacingOccurrences(of: " flag", with: "")
        cell.rLabel.text = "\(phoneValues![indexPath.row])"
        
        if phoneHeaders![indexPath.row] == "price" {
            if let text = navController.currency {
                cell.lLabel.text = "price \(text)"
                cell.rLabel.text = "\(navController.phone.getPriceByCurrency(code: navController.currency!))"
            }
        }
        
        
        
        
        
        return cell
    }

    
    // MARK: Actions
    @IBAction func Back(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

