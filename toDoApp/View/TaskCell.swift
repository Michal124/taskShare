//
//  TaskCell.swift
//  toDoApp
//
//  Created by Michał Górski on 28.12.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    
    func getTasktoCell(title : String , priority : String , author : String){
        self.titleLbl.text = title
        self.priorityLbl.text = priority
        self.authorLbl.text = author
        
        switch priorityLbl.text! {
        case "Low":
            self.priorityLbl.textColor = UIColor.blue
        case "Medium":
            self.priorityLbl.textColor = UIColor.yellow
        case "High":
            self.priorityLbl.textColor = UIColor.red
        default:
            print("No color")
        }
    }
    
    
}
