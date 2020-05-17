//
//  ScoreScreenView.swift
//  SiomSays
//
//  Created by Dan Cargill on 17/05/2020.
//  Copyright © 2020 Dan Cargill. All rights reserved.
//
import UIKit
import Foundation
class ScoreScreenView: UIViewController {
 

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton.layer.cornerRadius = 15
        newGameButton.layer.borderWidth = 1
               finalScoreLabel.text = ("\(global.finalScore)")
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fadeViewInThenOut(view: finalScoreLabel, delay: 0)
        
    }
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {

        let animationDuration = 1.5

        UIView.animate(withDuration: animationDuration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            view.alpha = 0
        }, completion: nil)

    }
    @IBAction func newGameButton(_ sender: UIButton) {
        
    }
  
}

