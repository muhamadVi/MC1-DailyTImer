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
    @IBOutlet weak var lblTaskName: UILabel!
    @IBOutlet weak var lblEstimatedTime: UILabel!
    @IBOutlet weak var lblCurrentSession: UILabel!
    @IBOutlet weak var lblTaskDesc: UILabel!
    
    //label kanan
    @IBOutlet weak var lblInTaskName: UILabel!
    @IBOutlet weak var lblInEstimatedTime: UILabel!
    @IBOutlet weak var lblInCurrentSession: UILabel!
    @IBOutlet weak var lblInTaskDesc: UILabel!
    
    // label timer
    @IBOutlet weak var lblTimerMinute: UILabel!
    @IBOutlet weak var lblTimerSecond: UILabel!
        
    var timer: Timer?
    var timeInput = 0
    var timeLeft = 0
    
    var currentSession = 1
    var totalSession = 10
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        startTimer()
            
        
        
        
        
        
    }
    func initUI(){
        self.timeLeft = timeInput
        lblTaskName.text = "Current Task: "
        lblEstimatedTime.text = "Estimated Time: "
        lblCurrentSession.text = "Current Session:"
        lblTaskDesc.text = "Task Description: "
        
        lblInTaskName.text = "" //nama task
        lblInEstimatedTime.text = "" //
        lblInCurrentSession.text = "\(currentSession)/\(totalSession)"
        lblInTaskDesc.text = ""
        
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
        print("sekarang sesi \(currentSession)")
        self.currentSession += 1
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func ToEndSession(_ sender: Any) {
        //self.performSegue(withIdentifier: "toEndSession", sender: nil)
        if currentSession <= totalSession{
            initUI()
            startTimer()
        }else{
            print("Session Done")
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
