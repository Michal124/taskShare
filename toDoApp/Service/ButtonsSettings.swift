//
//  RoundedButtons.swift
//  toDoApp
//
//  Created by Michał Górski on 29.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class ButtonsSettings: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 20
    }

}

class GoButton : UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 40
        self.backgroundColor = UIColor(red: 180/255, green: 107/255, blue: 146/255, alpha: 1)
    }
}
