//
//  UIViewControllerTransitionExt.swift
//  toDoApp
//
//  Created by Michał Górski on 17/02/2018.
//  Copyright © 2018 Michał Górski. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func presentNextVC( _ ViewController : UIViewController){
        let transitions = CATransition()
        transitions.duration = 0.4
        transitions.type = kCATransitionPush
        transitions.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transitions, forKey: kCATransition)
        present(ViewController, animated: false, completion: nil)
        
    }
    
    func dismissVC(){
        let transitions = CATransition()
        transitions.duration = 0.4
        transitions.type = kCATransitionPush
        transitions.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transitions, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
