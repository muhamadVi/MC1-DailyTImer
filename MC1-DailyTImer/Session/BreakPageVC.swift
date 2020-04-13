//
//  BreakPageVC.swift
//  MC1-DailyTImer
//
//  Created by Reyhan Rifqi on 08/04/20.
//  Copyright © 2020 Muhamad Vicky. All rights reserved.
//

import UIKit

class BreakPageVC: UIViewController {

    // label timer
    @IBOutlet weak var lblTimerMinute: UILabel!
    @IBOutlet weak var progressCircle: progressView!
    @IBOutlet weak var middleButton: UIButton!
    
    var timer: Timer?
    var timeInput = 0
    var timeLeft = 0
    
    var currentSession = 0
    var totalSession = 0
    
    var progress: Float = 0.0
    var progressLine = 0
    var fullCircle = 0
    
    var modeButton = "Start"

    override func viewDidLoad() {
        super.viewDidLoad()
        //untuk hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        progressCircle.trackColor = UIColor.white.withAlphaComponent(0.5)
        progressCircle.progressColor = UIColor(red: 22.0/255.0, green: 40.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        progressCircle.setProgressWithAnimation(duration: 1.0, value: 0.0)
        
        // Do any additional setup after loading the view.
        initUI()
        
    }
    
    func initUI(){
        
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
        middleButton.setImage(UIImage(named: "playBtn.png"), for: .normal)
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
            showAlert()
        }
        self.progressLine += 1
        timeLeft -= 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? Session{
            destination.currentSession = self.currentSession+1
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "", message: "Do you want to start focus?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes, back to focus", style: .default){
            (action) in
            self.navigationController?.popViewController(animated: true)
            self.timer?.invalidate()
        }
        let resume = UIAlertAction(title: "NO", style: .default){
            (action) in
            self.startTimer(timeleft: self.timeLeft, fullCircle: self.fullCircle)
        }
        alert.addAction(action)
        alert.addAction(resume)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func middlebutton(_ sender: Any) {
        switch modeButton {
        case "Start":
            startTimer(timeleft: self.timeLeft, fullCircle: self.timeLeft)
            self.modeButton = "Stop"
            middleButton.setImage(UIImage(named: "StopBtn.png"), for: .normal)

        case "Stop":
            timer?.invalidate()
                //ngasinh dia alert
                showAlert()
        default:
            0
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
