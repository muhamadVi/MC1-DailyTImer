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
    var timeInput = 75
    var breakInput = 20
    var currentSession = 1
    //ngitung banyaknya sesi
    var totalSession = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalSession = hitungTotalSesi(timeInput: 75, breakInput: 20)
        

        // Do any additional setup after loading the view.
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if currentSession <= totalSession{
            initUI()
        
            startTimer()
            print("sekarang sesi \(currentSession) total sesi ada \(totalSession)")
        }
        
        
    }
    
    
    func hitungTotalSesi(timeInput: Int, breakInput: Int) -> Int{
        return timeInput/breakInput
    }
    func initUI(){
        self.timeLeft = timeInput
        
        //lblTaskName.text = "Current Task: "
        lblEstimatedTime.text = "Estimated Time: "
        lblCurrentSession.text = "Current Session:"
        //lblTaskDesc.text = "Task Description: "
        
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
        if let destination = segue.destination as? BreakPageVC{
            destination.currentSession = currentSession
        }
    }
    
    @IBAction func ToEndSession(_ sender: Any) {
        self.performSegue(withIdentifier: "toEndSession", sender: nil)
//        if currentSession <= totalSession{
//            initUI()
//            startTimer()
//        }else{
//            print("Session Done")
//        }
    }
    
    @IBAction func unwindToSession(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        
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
