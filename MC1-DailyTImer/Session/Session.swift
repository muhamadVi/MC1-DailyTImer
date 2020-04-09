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
        
    var timer: Timer?
    var timeLeft = 0
    
    //buat nampung atribut task
    var taskName: String = ""
    var taskDesc: String = ""
    var timeInput = 0
    var breakInput = 0
    var currentSession = 1
    //ngitung banyaknya sesi
    var totalSession = 0
    var alert = UIAlertController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        if currentSession <= totalSession{
            initUI()
        
            startTimer()
            print("sekarang sesi \(currentSession) total sesi ada \(totalSession)")
            currentSession += 1
        }
        
        
    }
    
    
    
    func initUI(){
        self.timeLeft = timeInput
        
        //lblTaskName.text = "Current Task: "
        lblEstimatedTime.text = "Estimated Time: "
        lblCurrentSession.text = "Current Session:"
        //lblTaskDesc.text = "Task Description: "
        
        lblInTaskName.text = taskName
        lblInEstimatedTime.text = "\(timeInput)"
        lblInCurrentSession.text = "\(currentSession)/\(totalSession)"
        lblInTaskDesc.text = taskDesc
        
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
    }
    
    func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerFires), userInfo: nil, repeats: true)
        
    }
    
    @objc func onTimerFires(){
        timeLeft -= 1
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

        if timeLeft == 0 {
            timer?.invalidate()
            alert.dismiss(animated: true, completion: nil)
            showAlert(alertMessage: "Your Session is done. Go to break?")
            
            
        }
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
    
    @IBAction func btnStopped(_ sender: Any) {
        if timeLeft == 0{
            self.performSegue(withIdentifier: "toEndSession", sender: nil)
        }else{
            //ngasinh dia alert
            alert = UIAlertController(title: "", message: "You still need to focus. Are you sure want to stop?", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Quit", style: .default){
                (action) in self.navigationController?.popViewController(animated: true)
            }
            let gajadi = UIAlertAction(title: "gajadi", style: .cancel)
            
            alert.addAction(action)
            alert.addAction(gajadi)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func ToEndSession(_ sender: Any) {
        
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
