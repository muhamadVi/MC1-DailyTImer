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
    @IBOutlet weak var lblTimerSecond: UILabel!
    var timer: Timer?
    var timeInput = 0
    var timeLeft = 0
    
    var currentSession = 0
    var totalSession = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //untuk hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        
        // tanya ini, mau ganti label "back" di navigation bar
        //self.navigationItem.backBarButtonItem?.title = "s"
        
        // Do any additional setup after loading the view.
        initUI()
        startTimer()
        
    }
    
    func initUI(){
        
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
        if let destination = segue.destination as? Session{
            destination.currentSession = self.currentSession+1
        }
    }
    
    //untuk naro unwind segue di back button navigation bar
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
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
