//
//  ViewController.swift
//  toDoApp
//
//  Created by Michał Górski on 14.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.emailField.delegate = self
        self.passwordTxtField.delegate = self
        
    }
    
    
    @IBAction func emailLoginBtnPressed(_ sender: UIButton) {
        
        
        
        guard !(emailField.text!.isEmpty) else{
            
            let emailPopup = UIAlertController(title: "Wrong format", message: "Please write your email address", preferredStyle: .alert)
            
            emailPopup.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "email"
            })
            
            let emailSubmit = UIAlertAction(title: "save", style: .destructive, handler: { (save) in
                let emailPopupTextField = emailPopup.textFields![0] as UITextField
                
                self.emailField.text = emailPopupTextField.text
              
            })
            let emailCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
           
            emailPopup.addAction(emailCancel)
            emailPopup.addAction(emailSubmit)
            self.present(emailPopup, animated: true, completion: nil)
            
            return
        }
        
        guard !(passwordTxtField.text!.isEmpty) else {
            
            let passwordPopup = UIAlertController(title: "Wrong format", message: "Please write your password", preferredStyle: .alert)
            
            passwordPopup.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "password"
                textField.isSecureTextEntry = true
            })
            
            let passwordSubmit = UIAlertAction(title: "save", style: .destructive, handler: { (save) in
                let passwordPopupTextField = passwordPopup.textFields![0] as UITextField
                self.passwordTxtField.text = passwordPopupTextField.text
            })
            let passwordCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            passwordPopup.addAction(passwordCancel)
            passwordPopup.addAction(passwordSubmit)
            self.present(passwordPopup, animated: true, completion: nil)
            
            return
        }
        
        
        
        AuthenticationService.instance.login(byEmail: emailField.text!, andPassword: passwordTxtField.text!) { (succes, loginError) in
            if succes {
                let TabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
                self.present(TabBarVC!, animated: true)
            }else{
                print(loginError as Any)
                
                AuthenticationService.instance.register(byEmail: self.emailField.text!, andPassword: self.passwordTxtField.text!) { (succes, registerError) in
                    if succes {
                        AuthenticationService.instance.login(byEmail: self.emailField.text!, andPassword: self.passwordTxtField.text!) { (succes, registerError) in
                            if succes {
                                let testVC = self.storyboard?.instantiateViewController(withIdentifier: "AvatarVC")
                                self.present(testVC!, animated:true)
                                print("User was log in by email")
                            }
                        }
                    }else{
                        print("Error in register part: \(String(describing: registerError))")
                    }
                }
                
            }
        }
    }
    
    
    
    
    
    
    @IBAction func connectWithFacebook(_ sender: UIButton) {
        
        let login = FBSDKLoginManager()
    
        login.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result : FBSDKLoginManagerLoginResult!, error : Error?)  in
    
            guard result != nil else {
                FBSDKLoginManager().logOut()
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            AuthenticationService.instance.loginByFacebook(withCredential: credential) { (succes, error) in
                if succes{
                    let avatarVC = self.storyboard?.instantiateViewController(withIdentifier: "AvatarVC")
                    self.present(avatarVC!, animated: true)
                }
                
            }
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        return (true)
    }
    
    
}


