//
//  TaskList.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 07/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class TaskList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var editNameBtn: UIButton!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var taskTable: UITableView!
    
    /*
    struct Task {
             var taskName: String
             var taskDesc: String
             var estimatedTime: Int
             var timePerSession: Int
             var breakPerSession: Int
             var priority: String
            
    }*/
    
    
    let taskSections = ["Your Upcoming Task", "Your Completed Task"]
    
    let taskList = [[["name":"Coding", "desc":"Program Mini"], ["name":"Cuci", "desc":"piring gelas"]],
                    [["name":"Belajar", "desc":"Mandarin"]]]
    
    /*
    let upcomingTasks = [
            Task(taskName: "Coding", taskDesc: "MC-1"),
            Task(taskName: "Cuci", taskDesc: "Piring")
    ]
    
    let completedTasks = [
            Task(taskName: "Belajar", taskDesc: "Inggris")
    ]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.dataSource = self
        taskTable.delegate = self
        
        nameTxt.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func endEditing (_ sender: UITapGestureRecognizer){
        nameTxt.isEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.taskSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /*
        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Your Upcoming Task", comment: "mySectionName")
            case 1:
                sectionName = NSLocalizedString("Your Completed Task", comment: "myOtherSectionName")
            default:
                sectionName = ""
        }
        return sectionName
        */
        
        return self.taskSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if taskList.indices.contains(section) {
              return taskList[section].count
          } else {
              return 0
          }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  70
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskTableViewCell

        
        if taskList.indices.contains(indexPath.section) {
            cell.taskNameLb?.text = taskList[indexPath.section][indexPath.row]["name"]
            cell.taskDescLb?.text = taskList[indexPath.section][indexPath.row]["desc"]
        } else {
            cell.taskNameLb?.text = nil
            cell.taskDescLb?.text = nil
        }
        
        /*
        let task = tasks[indexPath.row]
        
        cell.taskNameLb?.text = task.taskName
        cell.taskDescLb?.text = task.taskDesc
        */
        
        return cell
    }
    
    
    @IBAction func editNameClicked(_ sender: Any) {
        nameTxt.isEnabled = true
        nameTxt.becomeFirstResponder()
    }
    
    @IBAction func ToAddTask(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddTask", sender: nil)
    }
    @IBAction func ToStartSession(_ sender: Any) {
        self.performSegue(withIdentifier: "toStartSession", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTask"{
            
        }else if segue.identifier == "toStartSession"{
            if let destination = segue.destination as? Session{
                //ini buat tes doang
                // nanti yang dikirim struct aja
                var totalsesi: Float = 30/20 //estimated sessionnya 30, time per session nya 20
                totalsesi.round()
                destination.timeInput = 20
                destination.totalSession = Int(totalsesi)
                destination.breakInput = 20
                destination.taskName = taskList[0][0]["name"]!
                destination.taskDesc = taskList[0][0]["desc"]!
            }
        }
    }
}

class taskTableViewCell: UITableViewCell {
      
    @IBOutlet weak var taskNameLb: UILabel!
    @IBOutlet weak var taskDescLb: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
}
