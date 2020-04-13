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
    @IBOutlet weak var toStartBtn: UIButton!
    
    let addTaskFile = AddTask()
    
    var userName = ""
    
  //  let donker = UIColor(hex: "#142850")
  //  let krem = UIColor(hex: "#EBCFB2")
    
    var upcomingTasks: [Task] = []
    
    var completedTasks:  [Task] = []
    
    var dataReceived: [Task] = []
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundTaskList.png")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
            
        toStartBtn.isHidden = true
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.init(displayP3Red: 28/255.0, green: 28/255.0, blue: 28/255.0, alpha: 1.0)
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 10, width:tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.textColor = UIColor.init(displayP3Red: 235/255.0, green: 207/255.0, blue: 178/255.0, alpha: 1.0)
        if section == 0 {
            headerLabel.text = "Your Upcoming Task"
        }else{
            headerLabel.text = "Your Completed Task"
        }
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 44
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
        
        if task.priority == "High" {
            cell.priorityImage.image = #imageLiteral(resourceName: "HighIcon")
        }else if task.priority == "Medium"{
            cell.priorityImage.image = #imageLiteral(resourceName: "MediumIcon")
        }else if task.priority == "Low"{
            cell.priorityImage.image = #imageLiteral(resourceName: "LowIcon")
        }
        
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
            dataReceived.removeAll()
        }
    }
    
    @IBAction func unwindToTaskListFromAddTask(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTask {

            dataReceived.insert(sourceViewController.dataPassed[0], at:0)
            upcomingTasks.insert(dataReceived[0], at: 0)
            dataReceived.removeAll()
            taskTable.reloadData()
        }
    }
}

class taskTableViewCell: UITableViewCell {
      
    @IBOutlet weak var taskNameLb: UILabel!
    @IBOutlet weak var taskDescLb: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
}
