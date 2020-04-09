//
//  AddTask.swift
//  MC1-DailyTImer
//
//  Created by Kevin Timotius on 08/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class AddTask: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var taskName = ""
    var taskDescription = ""
    
    struct CreateTask {
        var toDoName : String
        var toDoChoosen : String?
    }
    
    let taskSection = [
        CreateTask(toDoName: "Task Name"),
        CreateTask(toDoName: "Task Description"),
        CreateTask(toDoName: "Estimated Session",toDoChoosen: "Choose"),
        CreateTask(toDoName: "Time per Session",toDoChoosen: "Choose"),
        CreateTask(toDoName: "Breaktime per Session",toDoChoosen: "Choose"),
        CreateTask(toDoName: "Priority",toDoChoosen: "Choose")
    ]
    
    let estimatedSession = [1, 2, 3]
    let timePerSession = [25,30,35]
    let breakTimePerSession = [5,10,15]
    let priority = ["Low", "Medium", "High"]
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Create New Task"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskSection.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewTask", for: indexPath) as! CustomTaskCell
            let cons1 = taskSection[indexPath.row]
        }
        if indexPath.row > 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewTask-2", for: indexPath) as! CustomTaskCell
            let cons2 = taskSection[indexPath.row]
            cell.addTaskPicker?.text = cons2.toDoName
            
        }
        
        return UITableViewCell()
}
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

class CustomTaskCell: UITableViewCell{
    
    @IBOutlet weak var addTaskText: UITextField!
    @IBOutlet weak var addTaskPicker: UILabel!
    @IBOutlet weak var pickerViewChoosen: UILabel!
    
}
