//
//  Cell.swift
//  toDoApp
//
//  Created by Michał Górski on 26.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

  
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var userAvatar: RoundSquareButton!
    @IBOutlet weak var emailLbl: UILabel!


    func getDataToCell(userAvatar : String, email : String, content : String){
        self.emailLbl.text = email
        self.contentLbl.text = content
        self.userAvatar.setBackgroundImage(UIImage(named:userAvatar), for: UIControlState())
    }
    
    
  
}
