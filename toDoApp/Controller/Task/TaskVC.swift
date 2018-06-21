//
//  TaskVC.swift
//  toDoApp
//
//  Created by Michał Górski on 03.12.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase

class TaskVC: UIViewController{
    
    @IBOutlet weak var taskTable: UITableView!
    
    var taskArray = [Task]()
    var refleshControl : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTable.dataSource = self
        taskTable.delegate = self
    
        refleshControl.addTarget(self, action: #selector(TaskVC.uploadTask), for: UIControlEvents.valueChanged)
        taskTable.addSubview(refleshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uploadTask()
    }
    
    @objc func uploadTask(){
        DatabaseService.instance.getAllTask { (task) in
            
            self.taskArray = task
            self.taskTable.reloadData()
            switch self.taskArray.isEmpty {
            case false :
                self.taskTable.isHidden = false
            default:
                self.taskTable.isHidden = true
            }
            self.refleshControl.endRefreshing()
            self.sortArrayByPriority()
        }
    }
        
    func sortArrayByPriority(){
        
        self.taskArray.sort(by: { (Task1, Task2) -> Bool in
            if Task1.priority == "High" && (Task2.priority == "Medium" || Task2.priority == "Low") {
                return true
            } else if Task1.priority == "Medium" && Task2.priority == "Low" {
                return true
            }
            return false
        })
    }

    @IBAction func createTask(_ sender: Any) {
        guard let TaskSetVC = storyboard?.instantiateViewController(withIdentifier: "TaskSetVC") else {return}
        
        presentNextVC(TaskSetVC)
        
    }
    
}

extension TaskVC : UITableViewDelegate, UITableViewDataSource{
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskCell else {return UITableViewCell()}
        let tasks = taskArray[indexPath.row]
        cell.getTasktoCell(title: tasks.title, priority: tasks.priority, author: tasks.author)
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = taskArray[indexPath.row]
        print(selectedRow)
        performSegue(withIdentifier: "TaskDetailVC", sender: selectedRow)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let deletedRow = taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
            DatabaseService.instance.deleteTask(key: deletedRow.key)
            DatabaseService.instance.updateUserStatistics(statIsAdded: [false,false], andStatName: ["taskPrivate","taskInProgress"], maxIndex: 1)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TaskDetailVC {
            if let data = sender as? Task{
                destination.task = data
            }
        }
    }
    
}



