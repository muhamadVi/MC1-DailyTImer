//
//  AddTask.swift
//  MC1-DailyTImer
//
//  Created by Kevin Timotius on 08/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class AddTask: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var addTaskText: UITextField!
    @IBOutlet weak var addTaskText2: UITextField!
    @IBOutlet weak var estSessionField: UITextField!
    @IBOutlet weak var timeSessionField: UITextField!
    @IBOutlet weak var breakField: UITextField!
    @IBOutlet weak var priorityField: UITextField!
    
        
    var newPickerView = UIPickerView()
    var currentTextField = UITextField()

    var taskName: String = ""
    var taskDescription: String = ""
    var estimatedSession = 0
    var timePerSession = 0
    var breakTimePerSession = 0
    var priority = ""
    
    var estimatedSessionArr = ["1","2","3"]
    var timePerSessionArr = ["20","25","30"]
    var breakTimePerSessionArr = ["5","10","15"]
    var priorityArr = ["Low","Medium","High"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == estSessionField{
            return estimatedSessionArr.count
        }else if currentTextField == timeSessionField{
            return timePerSessionArr.count
        }else if currentTextField == breakField{
            return breakTimePerSessionArr.count
        }else if currentTextField == priorityField{
            return priorityArr.count
        }else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == estSessionField{
            return estimatedSessionArr[row]
        }else if currentTextField == timeSessionField{
            return timePerSessionArr[row]
        }else if currentTextField == breakField{
            return breakTimePerSessionArr[row]
        }else if currentTextField == priorityField{
            return priorityArr[row]
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == estSessionField{
            estSessionField.text = estimatedSessionArr[row]
        }else if currentTextField == timeSessionField{
            timeSessionField.text = timePerSessionArr[row]
        }else if currentTextField == breakField{
            breakField.text = breakTimePerSessionArr[row]
        }else if currentTextField == priorityField{
            priorityField.text = priorityArr[row]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentTextField = textField
        if currentTextField == addTaskText{
            textField.resignFirstResponder()
        }
        if currentTextField == addTaskText2{
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        newPickerView.dataSource = self
        newPickerView.delegate = self
        
        newPickerView.backgroundColor = UIColor(red: 207/255, green: 212/255, blue: 218/255, alpha: 1)
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (categoryDoneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector (categoryDoneClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
                
        currentTextField = textField
        currentTextField.inputAccessoryView = toolBar
        if currentTextField == estSessionField{
            estSessionField.inputView = newPickerView
        }else if textField == timeSessionField{
            timeSessionField.inputView = newPickerView
        }else if textField == breakField{
            breakField.inputView = newPickerView
        }else if textField == priorityField{
            priorityField.inputView = newPickerView
        }
    }
    
    @objc func categoryDoneClicked() {
        currentTextField.inputView = newPickerView
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskText.delegate = self
        addTaskText2.delegate = self
    }
    
    @IBAction func doneButton(_ sender: Any) {
        print(taskName)
        print(taskDescription)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
