//
//  DatabaseService.swift
//  toDoApp
//
//  Created by Michał Górski on 28.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DatabaseService {
    
    static let instance = DatabaseService()
    
    private var _REF_DBBASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_TASKS = DB_BASE.child("tasks")
    private var _REF_POSTS = DB_BASE.child("posts")
    
    private var userNodes = userNode.init(info: "info", stats: "stats")
    
    var REF_DBBASE : DatabaseReference {
        return _REF_DBBASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POSTS : DatabaseReference{
        return _REF_POSTS
    }
    
    var REF_TASKS : DatabaseReference{
        return _REF_TASKS
    }
    
    
    
    // ***************** USERS ***********************
    
    func updateUserValue(uid : String ,childName : String , dataName : Dictionary<String,Any?>) {
        REF_USERS.child(uid).child("info").updateChildValues(dataName)
    }
    
    func createDatabaseUser(uid : String ,userData : Dictionary<String, Any>, taskData : (Dictionary<String,Any>)?){
        REF_USERS.child(uid).child(userNodes.info).updateChildValues(userData)
        REF_USERS.child(uid).child(userNodes.stats).updateChildValues(taskData!)
    }
    
    func getUserData(uid : String, handler : @escaping(_ user: User ) ->()) {
        //wywala błąd gdy nie działa firebase
       
        
        REF_USERS.child(uid).observe(.value) { (dataSnap) in
            guard let value = dataSnap.value as? NSDictionary else {return}
            
            let info = value[self.userNodes.info] as! [String:Any]
            let stats = value[self.userNodes.stats] as! [String:Any]
            
            
            let email = info["email"] as? String ?? ""
            let name = info["name"] as? String ?? ""
            let avatar = info["Avatar"] as? String ?? ""
            let authentication = info["authentication"] as? String ?? ""
            
            let posts = stats["post"] as? Int ?? 0
            let completed = stats["taskCompleted"] as? Int ?? 0
            let inProgress = stats["taskInProgress"] as? Int ?? 0
            let myPrivate = stats["taskPrivate"] as? Int ?? 0
            let shared = stats["taskShared"] as? Int ?? 0
            
            let userData = User(email: email, fullname: name, avatar: avatar, authentication: authentication, posts: posts, completed: completed , inProgress: inProgress, myPrivate: myPrivate, shared: shared)
            
            handler(userData)
        }
        
    }
    
    
    
    func updateUserStatistics(statIsAdded added : [Bool], andStatName name : [String], maxIndex max : Int ){
        
        guard let user = Auth.auth().currentUser?.uid else {print("User isn't exist"); return}
        REF_USERS.child(user).child(self.userNodes.stats).runTransactionBlock { (currentData : MutableData) -> TransactionResult in
            
            if var value = currentData.value as? [String:Any] {
                
                for index in 0...max{
                    if var statValue = value[name[index]] as? Int{
                        switch added[index] {
                        case true:
                            statValue = statValue + 1
                        default:
                            if statValue > 0 {statValue = statValue - 1}
                        }
                        value[name[index]] = statValue as? AnyObject
                        currentData.value = value
                    }
                }
            }
            
            return TransactionResult.success(withValue: currentData)
        }
        
    }
    
    
    
    // ***************** POSTS ***********************
    
    func uploadPost(withmessage message : String , andEmail email : String , withKey groupKey : String? , andAvatar avatar : String , PostWasSend : @escaping (_ status : Bool) -> ()){
        if groupKey != nil {
            
        }else{
            _REF_POSTS.childByAutoId().updateChildValues(["content" : message , "userID" : email, "Avatar" : avatar])
            PostWasSend(true)
        }
    }
    
    
    func getAllPost(handler : @escaping(_ message : [Message]) ->()){
        var messageArray = [Message]()
        REF_POSTS.observeSingleEvent(of: DataEventType.value) { (messageSnapchot) in
            guard let messageSnap = messageSnapchot.children.allObjects as? [DataSnapshot] else {return}
            for userMessage in messageSnap{
                let content = userMessage.childSnapshot(forPath: "content").value as! String
                let userID = userMessage.childSnapshot(forPath: "userID").value as! String
                let avatar = userMessage.childSnapshot(forPath: "Avatar").value as! String
                let message = Message(content: content, userID: userID , avatar: avatar)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    func getEmail(forQuery query : String, handler: @escaping (_ emailArray : [String]) ->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnaphot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnaphot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if emailArray.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
        }
        handler(emailArray)
    }
    
    // ***************** TASKS ***********************
    
    func deleteTask(key : String ){
        let ref = REF_TASKS.child(key)
        ref.removeValue()
    }
    
    
    func uploadTask(byTitle taskTitle : String? , andPriority priority : String? , andTaskDescription description : String?, andDeadline deadline: String?, TaskWasSend : @escaping (_ status: Bool) ->()){
        
        guard taskTitle != "" else{
            TaskWasSend(false)
            return}
        
        let reference = REF_TASKS.childByAutoId()
        reference.updateChildValues(["author" : (Auth.auth().currentUser?.email)! , "authorID" : (Auth.auth().currentUser?.uid)!, "authorImageTitle" : "maul","description": description!, "title" : taskTitle!,"priority": priority, "deadline" : deadline ?? "Don't care'", "key" : reference.key ])
       
        
        
        TaskWasSend(true)
        
    }
    
    func getAllTask (handler : @escaping (_ task : [Task]) ->()){
        var taskArray = [Task]()
        REF_TASKS.observeSingleEvent(of: DataEventType.value) { (TaskSnapchot) in
            guard let taskSnap = TaskSnapchot.children.allObjects as? [DataSnapshot] else {return}
            
            for task in taskSnap{
                
                let title = task.childSnapshot(forPath: "title").value as! String
                let deadline = task.childSnapshot(forPath: "deadline").value as! String
                let description = task.childSnapshot(forPath: "description").value as! String
                let priority = task.childSnapshot(forPath: "priority").value as! String
                let author = task.childSnapshot(forPath: "author").value as! String
                let authorID = task.childSnapshot(forPath: "authorID").value as! String
                let authorImageTitle = task.childSnapshot(forPath: "authorImageTitle").value as! String
                let key = task.childSnapshot(forPath: "key").value as! String
                let task = Task(title: title, author: author, authorID: authorID, authorImageTitle: authorImageTitle, deadline: deadline, priority: priority, description: description, key: key)
                
                // private task ( maybe add something enums with case structure )
                if author == Auth.auth().currentUser?.email{
                    taskArray.append(task)
                }
                
            }
            
            handler(taskArray)
        }
        
    }
    
    
}




