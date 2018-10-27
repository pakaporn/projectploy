//
//  MyMenuScreen.swift
//  Project
//
//  Created by Pakaporn on 9/25/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MyMenuScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var tableView:UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self, action: Selector("sideMenu"))
//        self.navigationItem.leftBarButtonItem = newBackButton
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(sideMenu))
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "MyMenuScreenCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "Story MyMenu")
        tableView.backgroundColor = UIColor(white: 0.90,alpha:1.0)
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        } else {
            // Fallback on earlier versions
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
////
//       self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//       self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
////        self.revealViewController().rearViewRevealWidth = 240

//
        self.navigationController?.hidesBarsOnSwipe = true
        
        observePosts()
        
    }
//
//    @IBAction func backPage(_sender: Any) {
//        let pushed = SearchScreen()
//        self.navigationController?.pushViewController(pushed, animated: true)
//         //self.navigationController?.hidesBarsOnSwipe = true
//    }

   
    
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                    tempPosts.append(post)
                }
            }
            
            self.posts = tempPosts
            self.tableView.reloadData()
            //self.performSegue(withIdentifier: "back", sender: nil)
            
            
        })
    }

    @IBAction func handleLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Story MyMenu", for: indexPath) as! MyMenuScreenCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}


