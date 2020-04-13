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
    
    
    @IBOutlet weak var frameTaskName: UIView!
    @IBOutlet weak var frameTaskDesc: UIView!
    @IBOutlet weak var frameEstimated: UIView!
    @IBOutlet weak var frameTimePerSession: UIView!
    @IBOutlet weak var frameBreakTime: UIView!
    @IBOutlet weak var framePriority: UIView!
    
    
    
    
    
    
    var alert: UIAlertController!
    
    var dataPassed: [Task] = []
    var newPickerView = UIPickerView()
    var currentTextField = UITextField()
    
    /*DATA VARIABLE UNTUK DIPINDAHKAN:
    taskName, taskDescription, estimatedSession, timePerSession, breakTimePerSession, priority */
    var taskName: String{
             get {
                 return addTaskText.text ?? ""
             }
             set {
                 addTaskText.text = newValue
             }
         }
    var taskDescription: String{
             get {
                 return addTaskText2.text ?? ""
             }
             set {
                 addTaskText2.text = newValue
             }
         }
    var priority: String{
             get {
                 return priorityField.text ?? ""
             }
             set {
                 priorityField.text = newValue
             }
         }
    var estimatedSession: String{
             get {
                 return estSessionField.text ?? ""
             }
             set {
                 estSessionField.text = newValue
             }
         }
    var timePerSession: String{
             get {
                 return timeSessionField.text ?? ""
             }
             set {
                 timeSessionField.text = newValue
             }
         }
    var breakTimePerSession: String{
             get {
                 return breakField.text ?? ""
             }
             set {
                 breakField.text = newValue
             }
         }
    
    var estimatedSessionArr = [" ","1","2","3"]
    var timePerSessionArr = [" ","20","25","30"]
    var breakTimePerSessionArr = [" ","5","10","15"]
    var priorityArr = [" ","Low","Medium","High"]
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        newPickerView.dataSource = self
        newPickerView.delegate = self
        
        currentTextField = textField
        if textField == estSessionField{
            estSessionField.inputView = newPickerView
        }else if textField == timeSessionField{
            timeSessionField.inputView = newPickerView
        }else if textField == breakField{
            breakField.inputView = newPickerView
        }else if textField == priorityField{
            priorityField.inputView = newPickerView
        }
        
        newPickerView.backgroundColor = UIColor(red: 207/255, green: 212/255, blue: 218/255, alpha: 1)
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (categoryDoneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector (categoryDoneClicked))
        toolBar.setItems([spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        currentTextField.inputAccessoryView = toolBar

                
    }
    @objc func categoryDoneClicked() {
        currentTextField.inputView = newPickerView
        self.view.endEditing(true)
    }
    
    func showAlert() {
        alert = UIAlertController(title: "Error", message: "Please complete the form", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPickerView.reloadAllComponents()
        frameTaskName.layer.cornerRadius = 7
        frameTaskDesc.layer.cornerRadius = 7
        frameEstimated.layer.cornerRadius = 7
        frameTimePerSession.layer.cornerRadius = 7
        frameBreakTime.layer.cornerRadius = 7
        framePriority.layer.cornerRadius = 7
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if (taskName == "") || (taskDescription == "") || (estimatedSession == "") || (timePerSession == "") || (breakTimePerSession == "") || (priority == ""){
           showAlert()
        }else{
            self.dataPassed.append(Task( taskName: taskName, taskDesc: taskDescription, estimatedSession: Int(estimatedSession)!, timePerSession: Int(timePerSession)!, breakPerSession: Int(breakTimePerSession)!, priority: priority, status: false))
            performSegue(withIdentifier: "unwinfFromAddTask", sender: self)
        }
        newPickerView.reloadAllComponents()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
