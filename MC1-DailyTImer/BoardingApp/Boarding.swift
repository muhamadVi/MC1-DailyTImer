//
//  Boarding.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 08/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class Boarding: UIViewController {

    
    @IBOutlet weak var layoutInputName: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var saveUsername: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //untuk membuat shadow
//        layoutInputName.layer.shadowColor = UIColor.black.cgColor
//        layoutInputName.layer.shadowOpacity = 1
////        layoutInputName.layer.shadowOffset = .zero
//        layoutInputName.layer.shadowRadius = 5
//      untuk membuat border di view
//        username.layer.cornerRadius = 5
//        username.layer.borderColor = UIColor.black.cgColor
//        username.layer.borderWidth = 1
//        view.addSubview(username)
        
        layoutInputName.layer.cornerRadius = 8
        layoutInputName.layer.borderWidth = 1
        layoutInputName.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(layoutInputName)
        
//        saveUsername.layer.cornerRadius = 5
//        saveUsername.layer.borderColor = UIColor.black.cgColor
//        saveUsername.layer.borderWidth = 1
//        view.addSubview(saveUsername)
        
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskList"{
            print("totasklist")
        }
    }

    @IBAction func saveUsername(_ sender: Any) {
        self.performSegue(withIdentifier: "toTaskList", sender: nil)
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
