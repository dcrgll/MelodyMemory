//
//  RoundedButton.swift
//  SiomSays
//
//  Created by Dan Cargill on 16/05/2020.
//  Copyright © 2020 Dan Cargill. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func  awakeFromNib() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 1.0
            } else {
                alpha = 0.5
            }
        }
    }

}
