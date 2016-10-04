//
//  ViewController.swift
//  Seapare
//
//  Created by Yuan Yao on 2016-09-30.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import UIKit

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
        pickerView.delegate = self
        brandTextPicker.inputView = pickerView
        capacityTextPicker.inputView = pickerView
        priceTextPicker.inputView = pickerView
        cameraTextPicker.inputView = pickerView
        ramTextPicker.inputView = pickerView
        
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
    }
    
}

