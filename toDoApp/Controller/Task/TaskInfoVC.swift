//
//  TaskInfoVC.swift
//  toDoApp
//
//  Created by Michał Górski on 29.12.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class TaskInfoVC: UIViewController {
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UITextView!
    
    private var _task : Task!
    
    var task : Task{
        get{
            return _task
        }set{
            _task = newValue
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitle.text = _task.title
        taskDescription.text = _task.description
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
