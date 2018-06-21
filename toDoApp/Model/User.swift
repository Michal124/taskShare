//
//  user.swift
//  toDoApp
//
//  Created by Michał Górski on 23.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import Foundation

struct userNode {
    
    var info : String
    var stats: String
}


class User {
    
    private var _fullname : String
    private var _email : String
    private var _avatar : String
    private var _authentication : String
    
    private var _posts : Int
    private var _taskCompleted : Int
    private var _taskInProgress : Int
    private var _taskPrivate : Int
    private var _taskShared: Int
    
    var email : String {
        return _email
    }
    
    var fullname : String {
        return _fullname
    }
    
    var avatar : String {
        return _avatar
    }
    
    var authentication : String{
        return _authentication
    }
    
    var posts : Int {
        return _posts
    }
    
    var taskCompleted : Int {
        return _taskCompleted
    }
    
    var taskInProgress: Int {
        return _taskInProgress
    }
    
    var taskPrivate: Int {
        return _taskPrivate
    }
    
    var taskShared : Int {
        return _taskShared
    }
    
    init(email : String, fullname : String, avatar : String, authentication : String, posts : Int, completed : Int, inProgress : Int , myPrivate : Int, shared: Int ){
        
        self._email = email
        self._fullname = fullname
        self._avatar = avatar
        self._authentication = authentication
        
        self._posts = posts
        self._taskCompleted = completed
        self._taskInProgress = inProgress
        self._taskPrivate = myPrivate
        self._taskShared = shared
      
    }
}
