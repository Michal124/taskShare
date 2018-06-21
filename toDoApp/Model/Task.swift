//
//  Post.swift
//  toDoApp
//
//  Created by Michał Górski on 28.12.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import Foundation

class Task{
    
    private var _title : String
    private var _description : String
    private var _deadline : String
    private var _priority : String
    private var _author : String
    private var _authorImageTitle : String
    private var _authorID : String
    private var _key : String
    
    var title : String {
        return _title
    }
    
    var description : String{
        return _description
    }
    
    var deadline : String{
        return _deadline
    }
    
    var priority : String{
        return _priority
    }
    
    var author : String{
        return _author
    }
    
    var authorID : String{
        return _authorID
    }
    
    var authorImageTitle : String{
        return _authorImageTitle
    }
    
    var key : String{
        return _key
    }
    
    init(title : String, author : String,authorID : String, authorImageTitle :  String,  deadline : String, priority : String , description : String, key: String ){
        self._title = title
        self._description = description
        self._deadline = deadline
        self._author = author
        self._authorImageTitle = authorImageTitle
        self._authorID = authorID
        self._priority = priority
        self._key = key
      }

    
}
