//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progress: UIProgressView!
    
    
    @IBOutlet weak var label: UILabel!
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var totalTime = 0
    var secondsPassed : Float = 0.0
    var timer = Timer()
    var player : AVAudioPlayer!
    
    let hardness = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    
    @objc func updateCounter() {
        if secondsPassed < Float(totalTime) {
            secondsPassed+=0.01
            progress.progress = Float(secondsPassed) / Float(totalTime)
        }
        else {
            timer.invalidate()
            playSound(soundName: "alarm_sound")
            label.text = "Done."
        }
    }
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progress.progress = 0.0
        secondsPassed = 0.0
        label.text = sender.currentTitle
        totalTime = hardness[sender.currentTitle!]!
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
}
