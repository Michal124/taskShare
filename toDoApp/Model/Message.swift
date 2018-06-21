//
//  Message.swift
//  toDoApp
//
//  Created by Michał Górski on 26.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import Foundation

class Message {
    
    private var _content : String
    private var _userID  : String
    private var _avatar : String
    
    var userID : String {
        return _userID 
    }
    
    var content : String{
        return _content
    }
    
    var avatar : String{
        return _avatar
    }
    
    init(content : String, userID : String, avatar : String){
        self._content = content
        self._userID  = userID
        self._avatar = avatar
    }
}
