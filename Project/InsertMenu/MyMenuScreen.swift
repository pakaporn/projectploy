//
//  MyMenuScre.swift
//  Project
//
//  Created by Pakaporn on 11/12/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class MyMenuScreen: UITableViewController , UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postData = [Post]()
    var currentPostData = [Post]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    // 1. create a reference ot the db location you want to download
    let menuRef = Database.database().reference().child("posts")
    var menu = [Post]()
    var keepData = [Post]()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // download menu
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.menuRef.observe(.value, with: { (snapshot) in
                    self.menu.removeAll()
                    if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                        for child in snapshot.children {
                            let childSnapshot = child as! DataSnapshot
                            let menufood = Post(snapshot: childSnapshot)
                            self.menu.insert(menufood, at: 0)
                            if (user!.displayName == menufood.user.username) {
                                self.postData.append(menufood)
                                self.currentPostData = self.postData
                            }
                            self.tableView.reloadData()
                        }
                        //                    }
                        //                }
                    }
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetUp()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        title = "เมนูอาหารของฉัน"
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPostData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryMy Cell", for: indexPath) as! MyMenuScreenCell
        let menufood = currentPostData[indexPath.row]
        cell.usernameLabel.text = menufood.menu
        return cell
    }
    
    func searchBarSetUp() {
        let searchBar = UISearchBar(frame: CGRect(x: 0,y: 0, width:(UIScreen.main.bounds.width), height: 70))
        //searchBar.placeholder = "ค้นหาโดยชื่อเมนูอาหาร"
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["ค้นหาโดยชื่อเมนูอาหาร", "ค้นหาโดยวัตถุดิบ"]
        //searchBar.barTintColor = UIColor.blue
        searchBar.selectedScopeButtonIndex = 0
        searchBar.placeholder = "ค้นหา"
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentPostData = postData
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
            //self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
    func filterTableView(ind: Int, text: String){
        switch ind {
        case selectedScope.name.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.menu.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScope.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.ingredient.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScope.category.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.kindOFfood.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let keepMenuTest = currentPostData[indexPath.row].menu
            Database.database().reference().child("posts").observe(.value, with: { (snapshot) in
                if let result = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in result {
                        let userKey = child.key
                        let menufood = Post(snapshot: child)
                        self.keepData.insert(menufood, at: 0)
                        //print(self.keepData[0].menu)
                        if self.keepData[0].menu == keepMenuTest {
                            // print(userKey)
                            self.currentPostData.remove(at: indexPath.item)
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.menuRef.child(userKey).removeValue()
                        }
                    }
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "InsertMymenuDetail"
        if segue.identifier == iden {
            let insertMymenu = segue.destination as! MyMenuDetail
            //let searchCategory = segue.destination as! SearchByCategoryDetail
            let menu = currentPostData[tableView.indexPathForSelectedRow!.row].menu
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].ingredient
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].method
            let kindOFfood = currentPostData[tableView.indexPathForSelectedRow!.row].kindOFfood
            let photoURL = currentPostData[tableView.indexPathForSelectedRow!.row].photoURL
            let timestamp = currentPostData[tableView.indexPathForSelectedRow!.row].timestamp
            let username = currentPostData[tableView.indexPathForSelectedRow!.row].user.username
            let uid = currentPostData[tableView.indexPathForSelectedRow!.row].user.uid
            let uphotoURL = currentPostData[tableView.indexPathForSelectedRow!.row].user.photoURL
            let numberOfLikes = currentPostData[tableView.indexPathForSelectedRow!.row].numberOfLikes
            insertMymenu.menu = menu!
            insertMymenu.ingredient = ingredient!
            insertMymenu.photoURL = photoURL!
            insertMymenu.getCategory = kindOFfood!
            insertMymenu.method = method!
            insertMymenu.timestamp = timestamp!
            insertMymenu.uid = uid!
            insertMymenu.username = username!
            insertMymenu.uphotoURL = uphotoURL!
            insertMymenu.numberOfLikes = numberOfLikes
        }
    }
}
