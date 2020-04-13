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
    
    let donker = UIColor(hex: "#142850")
    let krem = UIColor(hex: "#EBCFB2")
    
    var upcomingTasks = [
        Task(taskName: "Coding", taskDesc: "MC-1", estimatedSession: 2, timePerSession: 10, breakPerSession: 5, priority: "high", status: true),
        Task(taskName: "Cuci", taskDesc: "Piring", estimatedSession: 3, timePerSession: 25, breakPerSession: 10, priority: "medium", status: true)
    ]
    
    var completedTasks = [
        Task(taskName: "Belajar", taskDesc: "Inggris", estimatedSession: 4, timePerSession: 15, breakPerSession: 10, priority: "low", status: false)
    ]
    
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
        if (section == 0) {
            headerView.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "SectionUpcomingTasks.png"))
        } else {
            headerView.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "SectionTaskCompleted.png"))
        }
        return headerView
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
        
        if task.priority == "high" {
            cell.priorityImage.image = #imageLiteral(resourceName: "HighIcon")
        }else if task.priority == "medium"{
            cell.priorityImage.image = #imageLiteral(resourceName: "MediumIcon")
        }else if task.priority == "low"{
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

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
