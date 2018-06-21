//
//  AvatarVC.swift
//  toDoApp
//
//  Created by Michał Górski on 24.10.2017.
//  Copyright © 2017 Michał Górski. All rights reserved.
//

import UIKit
import Firebase

class AvatarVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scroolView: UIScrollView!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var viewLayer: UIView!
    
    let userAvatars = ["kenobi","maul","beardy","hatty"]
    var avatarName : String! = "maul"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        scroolView.delegate = self
        let imageWidth : CGFloat = 250
        let imageHight : CGFloat = 250
        
        
        for i in 0...(userAvatars.count - 1) {
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: userAvatars[i])
            
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            let xPosition = scroolView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition + 10, y: (self.scroolView.frame.height/2 - imageHight/2), width: imageWidth, height: imageHight)
            scroolView.contentSize.width = scroolView.frame.width * CGFloat(i+1)
            scroolView.addSubview(imageView)
        }
        
        scroolView.clipsToBounds = false
         scroolView.contentOffset = CGPoint(x: 265, y: 0)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)  {
        
        let pageIndex = scroolView.contentOffset.x / scrollView.frame.size.width
//       print(scrollView.contentOffset)
        avatarName = selectedAvatar(pageIndex: pageIndex)
        avatarButton.setTitle(avatarName, for: UIControlState())
        avatarButton.setTitleColor(UIColor.white, for: UIControlState())
        avatarButton.backgroundColor = UIColor(red: 7/255, green: 176/255, blue: 179/255, alpha: 1)
        
    }
    
    func selectedAvatar(pageIndex : CGFloat) -> String {
        return userAvatars[Int(pageIndex)]
    }
    
    @IBAction func setAvatarIcon(_ sender: UIButton) {
               
        let avatarData = ["Avatar" : avatarName]
        
        DatabaseService.instance.updateUserValue(uid: (Auth.auth().currentUser?.uid)!, childName: "info", dataName: avatarData)
        let TabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        self.present(TabBarVC!, animated: true)
    }
    
 
    
    
}



