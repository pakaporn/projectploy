//
//  LogOutScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class LogOutScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.clipsToBounds = true
        logOutButton.layer.cornerRadius = logOutButton.bounds.height / 2
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    func set() {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                ImageService.getImage(withURL: (user?.photoURL)!  ) { image, url in
                    self.profileImage.image = image
                }
                self.userName.text = user?.displayName
            }
        }
        
        
        //        usernameLabel.text = post.author.username
        //        postTextLabel.text = post.text
        //        subtitleLabel.text = post.createdAt.calenderTimeSinceNow()
    }
    
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LogOut"
        if segue.identifier == iden {
            let logOutScreen = segue.destination as! LogOutScreen
        }
    }
    
    
}
