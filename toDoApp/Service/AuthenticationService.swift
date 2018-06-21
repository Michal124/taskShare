//
//  AuthenticationService.swift
//  toDoApp
//
//  Created by Michał Górski on 15.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import Foundation
import Firebase

import FBSDKLoginKit

private let initialTaskData = ["post" : 0 , "taskCompleted" : 0 ,
                               "taskInProgress" : 0 , "taskPrivate" : 0 , "taskShared" : 0]

class AuthenticationService{
    
    static var instance = AuthenticationService()
    
    func checkExistingUser(userStatus: @escaping (_ succes : Bool) ->()) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                userStatus(true)
            }else{
                userStatus(false)
            }
        }
    }
    
    func login(byEmail email : String , andPassword password : String, loginStatus:@escaping (_ status : Bool, _ error: Error?) ->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginStatus(false, error)
                return
            }
            loginStatus(true,nil)
            
        }
    }
    
    func register(byEmail email : String, andPassword password : String, registerStatus: @escaping (_ status : Bool, _ error : Error? ) -> () ){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else{
                registerStatus(false,error)
                return
            }
            let userData = ["avatar" : nil, "providerID" : user.providerID, "email" : user.email,"name" : user.displayName, "authentication" : "email"]
            DatabaseService.instance.createDatabaseUser(uid: (Auth.auth().currentUser?.uid)!, userData: userData, taskData: initialTaskData)
            registerStatus(true, nil)
            
            
        }
    }
    
    func loginByFacebook(withCredential accessPoint : AuthCredential, facebookStatus : @escaping (_ status  : Bool, _ error : Error?) ->()){
        Auth.auth().signIn(with: accessPoint) { (user, error) in
               guard let user = user else{
                facebookStatus(false, error)
                print(error!)
                return
            }
            let userData = ["avatar" : nil,"providerID" : user.providerID, "email" : user.email,"name" : user.displayName, "authentication" : "Facebook"]
            DatabaseService.instance.createDatabaseUser(uid: (user.uid), userData: userData, taskData: initialTaskData)
            facebookStatus(true, nil)
        }
    }
    
    func signOutNow( signOutStatus : (_ status : Bool , _ error : NSError?) ->()){
        do {
            try Auth.auth().signOut()
            signOutStatus(true, nil)
        } catch let signOutError as NSError {
            signOutStatus(false,signOutError)
        }
        
    }
    
    
    
    
}


