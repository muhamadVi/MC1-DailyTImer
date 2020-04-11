//
//  Boarding.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 08/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class Boarding: UIViewController, UITextFieldDelegate {

    
//    @IBOutlet weak var layoutInputName: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var saveUsername: UIButton!
    
    var userName = ""
    
    @IBOutlet weak var contoh: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //untuk membuat shadow
        
//        layoutInputName.layer.shadowColor = UIColor.black.cgColor
//        layoutInputName.layer.shadowOpacity = 1
//        layoutInputName.layer.shadowOffset = .zero
//        layoutInputName.layer.shadowRadius = 5
//      untuk membuat border di view
//        username.layer.cornerRadius = 5
//        username.layer.borderColor = UIColor.black.cgColor
//        username.layer.borderWidth = 1
//        view.addSubview(username)
        
//        layoutInputName.layer.cornerRadius = 8
//        layoutInputName.layer.borderWidth = 1
//        layoutInputName.layer.borderColor = UIColor.gray.cgColor
//        view.addSubview(layoutInputName)
        
//        saveUsername.layer.cornerRadius = 5
//        saveUsername.layer.borderColor = UIColor.black.cgColor
//        saveUsername.layer.borderWidth = 1
//        view.addSubview(saveUsername)
        
        // fitur untuk meng up and down keypad
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        textfield.resignFirstResponder()
        
        return true
    }
    
    // funt untuk up and down ketika di klik dimana saja
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskList"{
            if let destination = segue.destination as?
                TaskList{
                destination.userName = self.userName
            }

        }
    }

    
    @IBAction func saveUsername(_ sender: Any) {
        if let tempTxt = username.text{
            userName = tempTxt
        }
        self.performSegue(withIdentifier: "toTaskList", sender: nil)
        
    }
    

}
