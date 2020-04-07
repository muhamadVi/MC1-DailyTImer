//
//  TaskList.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 07/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class TaskList: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ToAddTask(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddTask", sender: nil)
    }
    @IBAction func ToStartSession(_ sender: Any) {
        self.performSegue(withIdentifier: "toStartSession", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTask"{
            
        }
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
