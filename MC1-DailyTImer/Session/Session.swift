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
    //@IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblEstimatedTime: UILabel!
    @IBOutlet weak var lblCurrentSession: UILabel!
    //@IBOutlet weak var lblTaskDesc: UILabel!
    
    //label kanan
    @IBOutlet weak var lblInTaskName: UILabel!
    @IBOutlet weak var lblInEstimatedTime: UILabel!
    @IBOutlet weak var lblInCurrentSession: UILabel!
    @IBOutlet weak var lblInTaskDesc: UILabel!
    
    // label timer
    @IBOutlet weak var lblTimerMinute: UILabel!
    @IBOutlet weak var lblTimerSecond: UILabel!
        
    @IBOutlet weak var progressCircle: progressView!
    @IBOutlet weak var middleButton: UIButton!
    var timer: Timer?
    var timeLeft = 0
    var progress: Float = 0.0
    var progressLine = 0
    var fullCircle = 0
    
    var waktu = 0
    
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        progressCircle.trackColor = UIColor.red
        progressCircle.progressColor = UIColor.blue
        progressCircle.setProgressWithAnimation(duration: 1.0, value: 0.0)

        self.progressLine = 0
        if currentSession > totalSession{
            alert = UIAlertController(title: "", message: "Are you done", preferredStyle: .alert)
            let action = UIAlertAction(title: "yes", style: .default){
                (action) in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
        }
        setUpPage()
    }
    
    
    
    func initUI(task: Task){
        self.task = task
        self.taskName = task.taskName
        self.taskDesc = task.taskDesc
        self.timeInput = task.estimatedTime*60
        self.breakInput = task.breakPerSession*60
        self.timeLeft = task.timePerSession*60
        let total = Float(timeInput)/Float(timeLeft)
        self.totalSession = Int(total.rounded(.up))
        self.waktu = task.timePerSession*60
    }
    func setUpPage(){
        lblCurrentSession.text = "Current Session"
        lblEstimatedTime.text = "Estimated Time"
        lblInTaskName.text = taskName
        lblInEstimatedTime.text = "\(timeInput)"
        lblInTaskDesc.text = taskDesc!

        let minute = timeLeft/60
        let second = timeLeft%60
        if minute >= 10{
            lblTimerMinute.text = "\(minute):"
        }else{
            lblTimerMinute.text = "0\(minute):"
        }
        if second >= 10 {
            lblTimerSecond.text = "\(second)"
        }else if second < 10 {
            lblTimerSecond.text = "0\(second)"
        }
         lblInCurrentSession.text = "\(currentSession)/\(totalSession)"
        middleButton.setTitle("Start", for: .normal)
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
        if minute >= 10{
            lblTimerMinute.text = "\(minute):"
        }else{
            lblTimerMinute.text = "0\(minute):"
        }
        if second >= 10 {
            lblTimerSecond.text = "\(second)"
        }else if second < 10 {
            lblTimerSecond.text = "0\(second)"
        }
        
        
        
        progress = Float(progressLine)/Float(self.fullCircle)
        progressCircle.setProgressWithAnimation(duration: 1.0, value: progress)
        print("\(progressLine): \(progress)")


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
            
            if self.currentSession < totalSession{
                startTimer(timeleft: waktu, fullCircle: waktu)
                
            }else if currentSession == totalSession{
                let sisaWaktu = self.timeInput % waktu
                startTimer(timeleft: sisaWaktu, fullCircle: sisaWaktu)
                
            }
            self.currentSession += 1
            self.modeButton = "pause"
            middleButton.setTitle("Pause", for: .normal)
            
        case "pause":
            timer?.invalidate()
            //ngasinh dia alert
            alert = UIAlertController(title: "", message: "You still need to focus.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Stop", style: .default){
                (action) in self.navigationController?.popViewController(animated: true)
                self.timer?.invalidate()
            }
            let gajadi = UIAlertAction(title: "Resume", style: .default){
                (action) in
                let sisaWaktu = self.timeInput % self.waktu
                self.startTimer(timeleft: self.timeLeft, fullCircle: sisaWaktu)
            }
            alert.addAction(action)
            alert.addAction(gajadi)
            self.present(alert, animated: true, completion: nil)
        default:
            0
        }
        
    }
    @IBAction func ToEndSession(_ sender: Any) {
        timer?.invalidate()
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
