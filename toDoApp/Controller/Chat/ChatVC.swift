//
//  ChatVC.swift
//  toDoApp
//
//  Created by Michał Górski on 12.11.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit

class ChatVC: UIViewController{
    
    
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var welcomeMessageStack: UIStackView!
    
    var refreshControl : UIRefreshControl = UIRefreshControl()
    var messageArray = [Message]()
    
    override func viewWillAppear(_ animated: Bool) {
        uploadChatContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTable.delegate = self
        contentTable.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(ChatVC.uploadChatContent), for: UIControlEvents.valueChanged)
        contentTable.addSubview(refreshControl)
    }
    
    @objc func uploadChatContent(){
        
        DatabaseService.instance.getAllPost { (Message) in
            self.messageArray = Message.reversed()
            self.contentTable.reloadData()
            switch self.messageArray.isEmpty{
                
            case false : self.contentTable.isHidden = false
                break
                
            default : self.contentTable.isHidden = true
                break
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    @IBAction func writePost(_ sender: Any) {
        guard let PostVC = storyboard?.instantiateViewController(withIdentifier: "PostVC") else {return}
        presentNextVC(PostVC)
    }
    
    
}

extension ChatVC : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatCell else {return UITableViewCell()}
        let message = messageArray[indexPath.row]
        cell.getDataToCell(userAvatar: message.avatar, email: message.userID, content: message.content)
        return cell
    }
    
    
}
