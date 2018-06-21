//
//  SetTaskVC.swift
//  toDoApp
//
//  Created by Michał Górski on 27.12.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase

class TaskSetVC: UIViewController {
    
    @IBOutlet weak var taskTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var actualDate : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDescriptionTextView.delegate = self
    }
    
    
    
    @IBAction func dateWasChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        actualDate = (dateFormatter.string(from: sender.date))
        print(actualDate)
    }
    
    @IBAction func taskTypeWasChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            taskTypeSegmentControl.tintColor = UIColor.blue
        case 1:
            taskTypeSegmentControl.tintColor = UIColor.yellow
        case 2:
            taskTypeSegmentControl.tintColor = UIColor.red
        default:
            taskTypeSegmentControl.tintColor = UIColor.blue
        }
        
    }
    
    
    @IBAction func completeTask(_ sender: UIButton) {
        
        DatabaseService.instance.uploadTask(byTitle: taskNameTextField.text, andPriority: taskTypeSegmentControl.titleForSegment(at: taskTypeSegmentControl.selectedSegmentIndex),andTaskDescription: taskDescriptionTextView.text, andDeadline : actualDate ) { (status) in
            
            if status {
                DatabaseService.instance.updateUserStatistics(statIsAdded: [true,true], andStatName: ["taskInProgress","taskPrivate"], maxIndex: 1)
                    self.dismissVC()}
                
            else{
                print("Not enough Data")
                
            }
        }
    }
    
    
    @IBAction func dismissVC(_ sender: UIButton) {
        dismissVC()
    }
    
    
}


extension TaskSetVC : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        taskDescriptionTextView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            taskDescriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
