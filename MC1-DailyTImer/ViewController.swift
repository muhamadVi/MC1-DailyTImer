//
//  ViewController.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 07/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskList"{
            print("totasklist")
        }
    }

    @IBAction func NextPage(_ sender: Any) {
        self.performSegue(withIdentifier: "toTaskList", sender: nil)
    }
    
}

