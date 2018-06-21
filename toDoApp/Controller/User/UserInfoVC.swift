//
//  UserInfoVC.swift
//  toDoApp
//
//  Created by Michał Górski on 24.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase


class UserInfoVC: UIViewController {
    
    var userDataArray = [User]()
    
    //******** UserData ********
    
    @IBOutlet weak var userAvatar: RoundSquareButton!
    @IBOutlet weak var userNameTxtField: RoundedCornerTextField!
    @IBOutlet weak var emailTxtField: RoundedCornerTextField!
    @IBOutlet weak var authenticationTxtField: RoundedCornerTextField!
    
    //******** taskUserData ********
    
    @IBOutlet weak var friendsBtn: roundLoginButton!
    @IBOutlet weak var completedBtn: roundLoginButton!
    @IBOutlet weak var inProgressBtn: roundLoginButton!
    @IBOutlet weak var privateBtn: roundLoginButton!
    @IBOutlet weak var sharedBtn: RoundSquareButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DatabaseService.instance.getUserData(uid: (Auth.auth().currentUser?.uid)!) { (user) in
            
            let avatar = UIImage(named: user.avatar )
            self.userAvatar.setBackgroundImage(avatar, for: UIControlState())
            self.userNameTxtField.text = user.fullname
            self.emailTxtField.text = user.email
            self.authenticationTxtField.text = user.authentication
            
         
            
            self.completedBtn.setTitle(String(user.taskCompleted), for: UIControlState())
            self.inProgressBtn.setTitle(String(user.taskInProgress), for: UIControlState())
            self.privateBtn.setTitle(String(user.taskPrivate), for: UIControlState())
            self.sharedBtn.setTitle(String(user.taskShared), for: UIControlState())
               self.friendsBtn.setTitle(String(user.posts), for: UIControlState())
        }
    }
    
    
    @IBAction func updateInfoBtn(_ sender: Any) {
        print("Data update was completed")
        dismiss(animated: true)
    }
    
    
    @IBAction func backToMainVCBtn(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonClicked) in
            
            AuthenticationService.instance.signOutNow { (userSignOut, error) in
                if userSignOut != false {
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                    self.present(loginVC!, animated: true, completion: nil)
                }
                
            }
        }
        
        logoutPopup.addAction(logoutAction)
        logoutPopup.addAction(cancelAction)
        self.present(logoutPopup, animated: true, completion: nil)
    }
    
    
    
    
    
    
}
