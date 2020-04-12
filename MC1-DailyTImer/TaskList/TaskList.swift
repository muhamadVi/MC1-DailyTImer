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
    
    let addTaskFile = AddTask()
    
    var userName = ""
    
    var upcomingTasks = [
        Task(taskName: "Coding", taskDesc: "MC-1", estimatedSession: 2, timePerSession: 10, breakPerSession: 5, priority: "high", status: true),
        Task(taskName: "Cuci", taskDesc: "Piring", estimatedSession: 3, timePerSession: 25, breakPerSession: 10, priority: "high", status: false)
    ]
    
    var completedTasks = [
        Task(taskName: "Belajar", taskDesc: "Inggris", estimatedSession: 4, timePerSession: 15, breakPerSession: 10, priority: "high", status: true)
    ]
    
    var dataReceived: [Task] = []
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkStatus()
        taskTable.reloadData()
        
        taskTable.dataSource = self
        taskTable.delegate = self
        
        nameTxt.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing (_:)))
        tapGesture.cancelsTouchesInView = false //nambah ini doang 1 baris
        self.view.addGestureRecognizer(tapGesture)
        
        // Untuk Meng-set Nama
        nameTxt.text = userName
    }
    
    func checkStatus(){
        var currentValue = 0
        for task in upcomingTasks {
            if(task.status == false){
                completedTasks.insert(task, at: 0)
                upcomingTasks.remove(at: currentValue)
            }
            currentValue += 1
        }
    }
    
    @objc func endEditing (_ sender: UITapGestureRecognizer){
        nameTxt.isEnabled = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return upcomingTasks.count
        }
        return completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  70
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! taskTableViewCell
        
        let task = indexPath.section == 0 ? upcomingTasks[indexPath.row] : completedTasks[indexPath.row]
        
        cell.taskNameLb?.text = task.taskName
        cell.taskDescLb?.text = task.taskDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let task  = upcomingTasks[indexPath.row]
            performSegue(withIdentifier: "toStartSession", sender: task)
            self.selectedCell = indexPath.row
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func editNameClicked(_ sender: Any) {
        nameTxt.isEnabled = true
        nameTxt.becomeFirstResponder()
    }
    
    @IBAction func ToAddTask(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddTask", sender: nil)
    }
    
    @IBAction func ToStartSession(_ sender: Any) {
        
        let task  = upcomingTasks[0]
        self.performSegue(withIdentifier: "toStartSession", sender: task)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTask"{
            
        }else if segue.identifier == "toStartSession"{
                if let destination = segue.destination as? Session{
                destination.initUI(task: sender as! Task)
            }
        }
    }
    
    @IBAction func unwindToTaskList(_ unwindSegue: UIStoryboardSegue) {
        if let dariSession = unwindSegue.source as? Session{
        // Use data from the view controller which initiated the unwind segue
            dataReceived.insert(dariSession.dataPassed[0], at:0)
            upcomingTasks[self.selectedCell] = dataReceived[0]
            checkStatus()
            taskTable.reloadData()
        }
    }
    
    @IBAction func unwindToTaskListFromAddTask(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTask {
            dataReceived[0] = sourceViewController.dataPassed[0]
            upcomingTasks.insert(dataReceived[0], at: 0)
        }
    }
}

class taskTableViewCell: UITableViewCell {
      
    @IBOutlet weak var taskNameLb: UILabel!
    @IBOutlet weak var taskDescLb: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
}
