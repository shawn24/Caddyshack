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
        
        do{
            let phones = try getCellPhonesByKeyword(keyword: "")
            for (index, element) in phones.getPhones().enumerated() {
                let name:String = (element as CellPhone).devie_type_name
                print("Item \(index): \(name)")
            }
            
            if let t = self.tabBarController {
                t.selectedIndex = 1
            } else {
                print("tabBarController is nil")
            }
        }
        catch let error as NSError {
            print("Could not create audio player: \(error)")
        }
        
    
        
    }
    

    func getCellPhonesByKeyword(keyword: String) throws -> CellPhoneSearchResultsList{
        let phoneList = CellPhoneSearchResultsList()
        dbQueue.inDatabase { db in
            for row in Row.fetch(db, "SELECT * FROM phone_table pt left join device_type_table dtt on pt.device_type_id = dtt.device_type_id left join brand_table bt on bt.brand_id = pt.brand_id order by pt.device_id asc") {
                let phone = CellPhone()
                phone.devie_type_name = row.value(named: "dt.device_id")
                phone.devie_type_name = row.value(named: "name")
                phoneList.append(phone: phone)
            }
        }
        
        return phoneList
    }
}

