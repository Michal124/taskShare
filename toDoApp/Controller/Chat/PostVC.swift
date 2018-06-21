//
//  PostVC.swift
//  toDoApp
//
//  Created by Michał Górski on 23.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var userImage: RoundSquareButton!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var sendMessageOutlet: roundLoginButton!
    
    var avatar : String!
    
    override func viewWillAppear(_ animated: Bool) {
        DatabaseService.instance.getUserData(uid: (Auth.auth().currentUser?.uid)!) { (user) in
            self.avatar = user.avatar
            self.userImage.setBackgroundImage(UIImage(named:self.avatar), for: UIControlState())
            self.userEmail.text = user.email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
  
    
    @IBAction func sendMessageBtn(_ sender: Any) {
        
        guard (self.textView.text != nil)  else {return}
        
        DatabaseService.instance.uploadPost(withmessage: textView.text, andEmail: (Auth.auth().currentUser?.email)!, withKey: nil, andAvatar: self.avatar ) { (isComplete) in
            if isComplete {
                DatabaseService.instance.updateUserStatistics(statIsAdded: [true], andStatName: ["post"], maxIndex: 0)
                    self.dismissVC()
            }else{
                print("Error")
            }
        }
    }
    
    
    @IBAction func backToChatVC(_ sender: Any) {
        dismissVC()
    }
    
    
}

extension PostVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

