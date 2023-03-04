//
//  ViewController.swift
//  CountdownTimer
//
//  Created by Jonni Akesson on 2017-04-20.
//  Copyright © 2017 Jonni Akesson. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, CountdownTimerDelegate {
    
    //MARK - Outlets
    
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var lequidButton: UIButton!
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    
    //MARK - Vars
    
    var countdownTimerDidStart = false
    
    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    let myTime: Int = 0
    
    // Test, for dev
    var selectedSecs: Int = 5
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame:CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.light)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Egg is Ready!"
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer.delegate = self
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        
        startBtn.isEnabled = false
        startBtn.alpha = 0.5
        
        configureButton()
        view.addSubview(messageLabel)
        
        var constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        
        messageLabel.isHidden = true
        counterView.isHidden = false
        
    }
    
    func configureButton() {
        self.lequidButton.layer.cornerRadius = 15
        self.softButton.layer.cornerRadius = 15
        self.hardButton.layer.cornerRadius = 15
    }
    

            
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - Countdown Timer Delegate
    
    func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
        hours.text = time.hours
        minutes.text = time.minutes
        seconds.text = time.seconds
    }
    
    
    func countdownTimerDone() {
        
        counterView.isHidden = true
        messageLabel.isHidden = false
        seconds.text = String(selectedSecs)
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print("countdownTimerDone")
    }
    
    
    //MARK: - Actions

    @IBAction func startTimer(_ sender: UIButton) {
        
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        stopBtn.isEnabled = true
        stopBtn.alpha = 1.0
        
        if !countdownTimerDidStart{
            countdownTimer.start()
            progressBar.start()
            countdownTimerDidStart = true
            startBtn.setTitle("PAUSE",for: .normal)
            
        } else{
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startBtn.setTitle("RESUME",for: .normal)
        }
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
    }
    
    @IBAction func didTappedLequidButton(_ sender: Any) {
        
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: 3)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: 3)
        
        self.softButton.backgroundColor = .clear
        self.lequidButton.backgroundColor = CustomColor.customSelectedButtonColor
        self.hardButton.backgroundColor = .clear
        
        startBtn.isEnabled = true
        startBtn.alpha = 1
    }
    
    @IBAction func didTappedMediumButton(_ sender: Any) {
        
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: 5)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: 5)
        
        self.lequidButton.backgroundColor = .clear
        self.softButton.backgroundColor = CustomColor.customSelectedButtonColor
        self.hardButton.backgroundColor = .clear
        
        startBtn.isEnabled = true
        startBtn.alpha = 1
    }
    
    @IBAction func didTappedHardButton(_ sender: Any) {
        
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: 10)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: 10)
        
        self.lequidButton.backgroundColor = .clear
        self.softButton.backgroundColor = .clear
        self.hardButton.backgroundColor = CustomColor.customSelectedButtonColor
        
        startBtn.isEnabled = true
        startBtn.alpha = 1
    }
}

