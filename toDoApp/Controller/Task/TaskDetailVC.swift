//
//  TaskDetailVC.swift
//  toDoApp
//
//  Created by Michał Górski on 04.01.2018.
//  Copyright © 2018 Michał Górski. All rights reserved.
//

import UIKit

class TaskDetailVC: UITableViewController {

    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var taskDeadlineLbl: UILabel!
    @IBOutlet weak var taskPriorityLbl: UILabel!
    @IBOutlet weak var taskStatusLbl: UILabel!
    @IBOutlet weak var taskDescriptionLbl: UITextView!
    @IBOutlet weak var taskAuthorImage: RoundSquareButton!
    @IBOutlet weak var taskAuthorEmail: UILabel!
    
    @IBOutlet weak var friendsBtn: roundLoginButton!
    @IBOutlet weak var completedBtn: roundLoginButton!
    @IBOutlet weak var inProgressBtn: roundLoginButton!
    @IBOutlet weak var privateBtn: roundLoginButton!
    @IBOutlet weak var sharedBtn: RoundSquareButton!
    
    
    
//    @IBOutlet weak var subtaskTable: UITableView!
    
    private var _task : Task!
    
    var task : Task{
        get{
            return _task
        }set{
            _task = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        subtaskTable.delegate = self
//        subtaskTable.dataSource = self
        updateData()
        DatabaseService.instance.getUserData(uid: _task.authorID) { (user) in
            
            self.completedBtn.setTitle(String(user.taskCompleted), for: UIControlState())
            self.inProgressBtn.setTitle(String(user.taskInProgress), for: UIControlState())
            self.privateBtn.setTitle(String(user.taskPrivate), for: UIControlState())
            self.sharedBtn.setTitle(String(user.taskShared), for: UIControlState())
            self.friendsBtn.setTitle(String(user.posts), for: UIControlState())
        }
        
    }
    
   

    func updateData(){
        
        taskTitleLbl.text = _task.title
        taskAuthorEmail.text = _task.author
        taskDeadlineLbl.text = _task.deadline
        
        taskDescriptionLbl.text = _task.description
        taskStatusLbl.text = "In progress"
        taskAuthorImage.setBackgroundImage(UIImage(named:_task.authorImageTitle), for: UIControlState())
       
        taskPriorityLbl.text = _task.priority
        switch taskPriorityLbl.text! {
        case "Low":
            self.taskPriorityLbl.textColor = UIColor.blue
        case "Medium":
            self.taskPriorityLbl.textColor = UIColor.yellow
        case "High":
            self.taskPriorityLbl.textColor = UIColor.red
        default:
            print("No color")
        }
        
        
    }
   
    @IBAction func backtoPreviousVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 5
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
