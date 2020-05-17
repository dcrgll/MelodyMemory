//
//  ViewController.swift
//  SiomSays
//
//  Created by Dan Cargill on 15/05/2020.
//  Copyright © 2020 Dan Cargill. All rights reserved.
//

import UIKit
import AVFoundation

var global = Global()
var audioPlayer = AVAudioPlayer()

class ViewController: UIViewController {

var sequenceIndex = 0
var finalScore = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var colorButtons: [RoundedButton]!
    @IBOutlet weak var actionButton: UIButton!
    
    
    var colorSequence = [Int]()
    var colorsToTap = [Int]()
    var gameEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtons = colorButtons.sorted(){
            $0.tag < $1.tag
        }
        createNewGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded {
            gameEnded = false
            createNewGame()
        }
    }
    
   
  
    
    func createNewGame() {
        finalScore = 0
        colorSequence.removeAll()
        
        actionButton.setTitle("Start Game", for: .normal)
        actionButton.isEnabled = true
        for button in colorButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
        
        
    }
    
    func addNewColor(){
        colorSequence.append(Int(arc4random_uniform(UInt32(5))))
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(button: colorButtons[colorSequence[sequenceIndex]])
            print("Print colorSequence: \(colorSequence)")
            sequenceIndex += 1
            
        } else {
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("Tap The Buttons", for: .normal)
            for button in colorButtons {
                button.isEnabled = true
            }
        }
    }
    
   
    
    func flash(button: RoundedButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 1.0
            button.alpha = 0.5
        }) { (bool) in
            self.playSequence()
            
        }
        if let popSound = Bundle.main.url(forResource: "\(button.tag)", withExtension: "mp3") {

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: popSound)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
        }
    }
    
    
    func endGame() {
        
        actionButton.setTitle(" ", for: .normal)
        
        gameEnded = true
        self.performSegue(withIdentifier: "segue", sender: self)
        print("Final Score: \(global.finalScore)")
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        createNewGame()
    }

    @IBAction func colorButtonHandles(_ sender: RoundedButton) {
         // Play Sound on Tap
        if let popSound = Bundle.main.url(forResource: "\(sender.tag)", withExtension: "mp3") {

           do {
               audioPlayer = try AVAudioPlayer(contentsOf: popSound)
           }
           catch {
               print(error)
           }
           audioPlayer.play()
           }
        
        // Check against Sequence
        print(sender.tag)
        if sender.tag == colorsToTap.removeFirst(){
            
        } else {
            for button in colorButtons {
                           button.isEnabled = false
                       }
            endGame()
            return
        }
        if colorsToTap.isEmpty {
            for button in colorButtons {
            button.isEnabled = false
                       }
            actionButton.setTitle("Continue", for: .normal)
            actionButton.isEnabled = true
            global.finalScore = sequenceIndex
            
        }
   
        
        
    }
    
    @IBAction func actionButtonHandler(_ sender: Any) {
        sequenceIndex = 0
        actionButton.setTitle("Memorise", for: .normal)
        actionButton.isEnabled = false
        view.isUserInteractionEnabled = false
        addNewColor()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.playSequence()
        }
    }
}

