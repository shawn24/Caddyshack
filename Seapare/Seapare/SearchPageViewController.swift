//
//  ViewController.swift
//  Seapare
//
//  Created by Yuan Yao on 2016-09-30.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit
import GRDB

class SearchPageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    


    // MARK: Properties
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var brandTextPicker: UITextField!
    @IBOutlet weak var capacityTextPicker: UITextField!
    @IBOutlet weak var priceTextPicker: UITextField!
    @IBOutlet weak var cameraTextPicker: UITextField!
    @IBOutlet weak var ramTextPicker: UITextField!
    
    
    var brandOption = ["","Apple", "Sumsung", "Huawei", "SuperSuperHotPhone", "HAHA"]
    var capacityOption = ["","capacity","capacity2"]
    var priceOption = ["","price","price2"]
    var cameraOption = ["","camera","camera2"]
    var ramOption = ["","ram","ram2"]
    
    var selectedPickerOption:Array<String>?
    var selectedTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keywordTextField.delegate = self
        brandTextPicker.delegate = self
        capacityTextPicker.delegate = self
        priceTextPicker.delegate = self
        cameraTextPicker.delegate = self
        ramTextPicker.delegate = self
        
        // Change the text fields' input view to picker view
        let pickerView = UIPickerView()
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        pickerView.delegate = self
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SearchPageViewController.endEditing))
        toolBar.setItems([space,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        brandTextPicker.inputView = pickerView
        brandTextPicker.inputAccessoryView = toolBar
        capacityTextPicker.inputView = pickerView
        capacityTextPicker.inputAccessoryView = toolBar
        priceTextPicker.inputView = pickerView
        priceTextPicker.inputAccessoryView = toolBar
        cameraTextPicker.inputView = pickerView
        cameraTextPicker.inputAccessoryView = toolBar
        ramTextPicker.inputView = pickerView
        ramTextPicker.inputAccessoryView = toolBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Functions
    
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder{
            return self.view as UIView!
        }
        
        for subview:UIView in self.view.subviews {
            if subview.isFirstResponder {
                return subview
            }
        }
        
        return nil
        
    }
    
    func endEditing(){
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        selectedTextField = textField
        switch textField {
        case keywordTextField:
            break
        case brandTextPicker:
            selectedPickerOption = brandOption
            break
        case capacityTextPicker:
            selectedPickerOption = capacityOption
            break
        case priceTextPicker:
            selectedPickerOption = priceOption
            break
        case cameraTextPicker:
            selectedPickerOption = cameraOption
            break
        case ramTextPicker:
            selectedPickerOption = ramOption
            break
        default:
            break
        }
 
        let picker = textField.inputView
        if picker is UIPickerView {
            (picker as! UIPickerView).reloadAllComponents()
            (picker as! UIPickerView).selectRow(0, inComponent: 0, animated: true)
        }
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIPickerViewDelegate
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int {
        // Set number of components in picker view
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Set number of rows in components
        
        if let s = selectedPickerOption {
            return s.count
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Set title for each row
        
        if let s = selectedPickerOption {
            return s[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update textfield text when row is selected
        
        if let s = selectedPickerOption , let t = selectedTextField {
            t.text = s[row]
        }
    }
    
    // MARK: Actions
    @IBAction func search(_ sender: AnyObject) {
        print("Search!")
        
            let phones = getCellPhones(keyword: nil,brand: nil,capacity: nil,price: nil,camera: nil,ram: nil)
            for (index, element) in phones.getPhones().enumerated() {
                let name:String = (element as CellPhone).cellphone_name
                print("Item \(index): \(name)")
            }
            
            if let t = self.tabBarController {
                t.selectedIndex = 1
            } else {
                print("tabBarController is nil")
            }
        
        
    
        
    }
    
    func getCellPhones(keyword: String?, brand: String?, capacity: String?, price: String?, camera: String?, ram: String?) -> CellPhoneSearchResultsList{
        
        var keywordString = ""
        var brandString = ""
        var capacityString = ""
        var priceString = ""
        var cameraString = ""
        var ramString = ""
        var queryString = "SELECT * FROM phone_table pt left join device_type_table dtt on pt.device_type_id = dtt.device_type_id left join brand_table bt on bt.brand_id = pt.brand_id"
        if (keyword != nil) { keywordString = ("name = \"" + keyword! + "\"")}
        if (brand != nil) { brandString = "brand_name = \"" + brand! + "\""}
        if (capacity != nil) { capacityString = "capacity = " + capacity! }
        if (price != nil) { priceString = "price_cdn = " + price!}
        if (camera != nil) { cameraString = "camera_mp = " + camera!}
        if (ram != nil) { ramString = "ram_mb = " + ram!}
        
        var criteria_list = [keywordString, brandString, capacityString, priceString, cameraString, ramString].filter{(str) in str != ""}
        if !criteria_list.isEmpty {
            if criteria_list.count == 1 {
                queryString += " where " + criteria_list[0]
            }
            else {
                let criteriaString = criteria_list.joined(separator: " and ")
                queryString += " where " + criteriaString
            }
        }
        
        do{
            let phones = try self.makeQuery(query: queryString)
            for (index, element) in phones.getPhones().enumerated() {
                let name:String = (element as CellPhone).cellphone_name
                print("Item \(index): \(name)")
            }
            return phones
        }
        catch let error as NSError {
            print("Could not get phones by keyword: \(error)")
        }
        return CellPhoneSearchResultsList()
    }

    func makeQuery(query: String) throws -> CellPhoneSearchResultsList{
        let phoneList = CellPhoneSearchResultsList()
        dbQueue.inDatabase { db in
            for row in Row.fetch(db, query) {
                let phone = CellPhone()
                phone.device_id = row.value(named: "device_id")
                phone.device_type_id = row.value(named: "device_id")
                phone.device_type_name = row.value(named: "device_type_name")
                let brand = Brand()
                brand.brand_id = row.value(named: "brand_id")
                brand.brand_name = row.value(named: "brand_name")
                phone.brand_obj = brand
                
                phone.cellphone_name = row.value(named: "name")
                phone.phone_id = row.value(named: "phone_id")
                phone.colour = row.value(named: "color")
                phone.price = row.value(named: "price_cdn")
                phone.network = row.value(named: "network")
                phone.screen_size = row.value(named: "screen_size_inch")
                phone.ppi = row.value(named: "ppi")
                phone.resolution = row.value(named: "resolution")
                phone.ram = row.value(named: "ram_mb")
                phone.capacity = row.value(named: "capacity")
                phone.device_size = row.value(named: "device_size_mm")
                phone.camera_resolution = row.value(named: "camera_mp")
                phone.platform = row.value(named: "platform")
                phone.gps_flag = row.value(named: "gps")
                phone.bluetooth_flag = row.value(named: "bluetooth")
                phone.nfc_flag = row.value(named: "nfc")
                phone.memory_card_support_flag = row.value(named: "memory_card")
                phone.fingerprint_flag = row.value(named: "fingerprint")
                phone.warranty = row.value(named: "warranty_m")
                phone.processor = row.value(named: "processor")
                phone.standby_hour = row.value(named: "standby_h")
                phone.talktime_hour = row.value(named: "talktime_h")
                phone.weight = row.value(named: "weight_g")
                phoneList.append(phone: phone)
            }
        }
        
        return phoneList
    }
}

