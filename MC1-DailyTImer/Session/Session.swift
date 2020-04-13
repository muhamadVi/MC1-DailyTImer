//
//  Session.swift
//  MC1-DailyTImer
//
//  Created by Muhamad Vicky on 07/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class Session: UIViewController {
    //label kiri
    @IBOutlet weak var lblCurrentSession: UILabel!
    
    //label kanan
    @IBOutlet weak var lblInTaskName: UILabel!
    @IBOutlet weak var lblInCurrentSession: UILabel!
    @IBOutlet weak var lblInTaskDesc: UILabel!
    
    // label timer
    @IBOutlet weak var lblTimerMinute: UILabel!
        
    @IBOutlet weak var progressCircle: progressView!
    @IBOutlet weak var middleButton: UIButton!
    var timer: Timer?
    var timeLeft = 0
    var progress: Float = 0.0
    var progressLine = 0
    var fullCircle = 0
    
    
    //buat nampung atribut task
    var taskName: String = ""
    var taskDesc: String?
    var timeInput = 0
    var breakInput = 0
    var currentSession = 1
    //ngitung banyaknya sesi
    var totalSession = 0
    var alert = UIAlertController()
    var task: Task?
    var modeButton = "start"
    
    var dataPassed: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        progressCircle.trackColor = UIColor.white.withAlphaComponent(0.5)
        progressCircle.progressColor = UIColor(red: 22.0/255.0, green: 40.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        progressCircle.setProgressWithAnimation(duration: 1.0, value: 0.0)

        self.progressLine = 0
        if currentSession > totalSession{
            alert = UIAlertController(title: "", message: "Have you finished your task?", preferredStyle: .alert)
            let no = UIAlertAction(title: "No", style: .default) { (action) in
                self.startTimer(timeleft: self.timeInput, fullCircle: self.timeInput)
            }
            let action = UIAlertAction(title: "Yes", style: .default){
                (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(no)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
        }else{
            self.timeLeft = task!.timePerSession
            setUpPage()
        }
    }
    
    
    
    func initUI(task: Task){
        self.task = task
        self.taskName = task.taskName
        self.taskDesc = task.taskDesc
        self.timeInput = task.timePerSession
        self.breakInput = task.breakPerSession
        self.timeLeft = task.timePerSession
        self.totalSession = task.estimatedSession
    }
    func setUpPage(){
        lblCurrentSession.text = "Current Session"
        
        lblInTaskName.text = taskName
        
        lblInTaskDesc.text = taskDesc!

        let minute = timeLeft/60
        let second = timeLeft%60
        if (minute >= 10) && (second >= 10){
            lblTimerMinute.text = "\(minute):\(second)"
        }else if (minute >= 10) && (second < 10){
            lblTimerMinute.text = "\(minute):0\(second)"
        }else if (minute < 10) && (second >= 10){
            lblTimerMinute.text = "0\(minute):\(second)"
        }else if (minute < 10) && (second < 10){
            lblTimerMinute.text = "0\(minute):0\(second)"
        }
         lblInCurrentSession.text = "\(currentSession)/\(totalSession)"

        //middleButton.setTitle(nil, for: .normal)
        middleButton.setImage(UIImage(named: "playBtn.png"), for: .normal)
        self.modeButton = "start"
        
    }
    
    func startTimer(timeleft: Int, fullCircle: Int){
        self.timeLeft = timeleft
        self.fullCircle = fullCircle
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires(){
        
        let minute = timeLeft/60
        let second = timeLeft%60
        if (minute >= 10) && (second >= 10){
            lblTimerMinute.text = "\(minute):\(second)"
        }else if (minute >= 10) && (second < 10){
            lblTimerMinute.text = "\(minute):0\(second)"
        }else if (minute < 10) && (second >= 10){
            lblTimerMinute.text = "0\(minute):\(second)"
        }else if (minute < 10) && (second < 10){
            lblTimerMinute.text = "0\(minute):0\(second)"
        }
        
        progress = Float(progressLine)/Float(self.fullCircle)
        progressCircle.setProgressWithAnimation(duration: 1.0, value: progress)

        if timeLeft == 0 {
            timer?.invalidate()
            alert.dismiss(animated: true, completion: nil)
            showAlert(alertMessage: "Your Session is done. Go to break?")
        }
        timeLeft -= 1
        self.progressLine += 1
        
    }
    
    func showAlert(alertMessage: String) {
        alert = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Oke", style: .cancel){
            (action) in
             self.performSegue(withIdentifier: "toEndSession", sender: nil)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreakPageVC{
            destination.timeLeft = breakInput
        }
    }
    
    @IBAction func btnPause(_ sender: Any) {
        switch modeButton {
        case "start":
            
                startTimer(timeleft: timeInput, fullCircle: timeInput)
            self.currentSession += 1
            self.modeButton = "pause"
            middleButton.setTitle(nil, for: .normal)
            middleButton.setImage(UIImage(named: "StopBtn.png"), for: .normal)
            
        case "pause":
            timer?.invalidate()
            //ngasinh dia alert
            alert = UIAlertController(title: "", message: "You still need to focus.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Stop", style: .default){
                (action) in
                self.navigationController?.popViewController(animated: true)
                
                self.timer?.invalidate()
            }
            let resume = UIAlertAction(title: "Resume", style: .default){
                (action) in
                self.startTimer(timeleft: self.timeLeft, fullCircle: self.timeInput)
            }
            alert.addAction(action)
            alert.addAction(resume)
            self.present(alert, animated: true, completion: nil)
        default:
            0
        }
        
    }
    @IBAction func ToEndSession(_ sender: Any) {
        timer?.invalidate()
        alert = UIAlertController(title: "", message: "Are you sure have finish this task?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "No", style: .cancel){
            (action) in
             self.startTimer(timeleft: self.timeLeft, fullCircle: self.timeInput)
        }
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.dataPassed.append( Task( taskName: self.task!.taskName, taskDesc: self.task!.taskDesc, estimatedSession: Int(self.task!.estimatedSession), timePerSession: Int(self.task!.timePerSession), breakPerSession: Int(self.task!.breakPerSession), priority: self.task!.priority, status: false))
            self.performSegue(withIdentifier: "undwindFromSession", sender: self)
            
        }
        
        alert.addAction(action)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
//
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
