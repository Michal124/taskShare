//
//  RoundedCorner.swift
//  toDoApp
//
//  Created by Michał Górski on 08.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class RoundSquareButton: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
    }

}

class RoundCornerButton : UIButton{
    override func awakeFromNib() {
        self.layer.cornerRadius = 20
    }
}

class roundLoginButton : UIButton{
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
    }
}

class RoundedCornerTextField : UITextField {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 2
    }
    
}

class RoundedCornerView : UIView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.1
       
    }
}




