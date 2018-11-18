//
//  MenuFavouriteScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

enum selectedScopeMenuFavorite: Int {
    case name = 0
    case ingredients = 1
}

class MenuFavoriteScreen: UITableViewController , UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var postData = [MenuFavorite]()
    var currentPostData = [MenuFavorite]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    // 1. create a reference ot the db location you want to download
    let menuRef = Database.database().reference().child("menuFavorite")
    var mymenu = [MenuFavorite]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            self.mymenu.removeAll()
            
            if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = MenuFavorite(snapshot: childSnapshot)
                    self.mymenu.insert(menufood, at: 0)
                    self.postData.append(menufood)
                    self.currentPostData = self.postData
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.searchBarSetUp()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        title = "เมนูอาหารจานโปรด"
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func searchBarSetUp(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width:(UIScreen.main.bounds.width), height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["ค้นหาโดยชื่อเมนูอาหาร", "ค้นหาโดยวัตถุดิบ"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            currentPostData = postData
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
        }
        self.tableView.reloadData()
    }
    
    func filterTableView(ind: Int, text: String){
        switch ind {
        case selectedScopeMenuFavorite.name.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.menu.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScopeMenuFavorite.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.ingredient.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
//       switch ind  {
//        case selectedScopeMenuFavorite.category.rawValue:
//            currentPostData = postData.filter({ (mod) -> Bool in
//                return mod.getCategory().lowercased().contains(text.lowercased())
//            })
//            self.tableView.reloadData()
//        default:
//            print("No Data")
//        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currentPostData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryFav Cell", for: indexPath) as! MenuFavoriteCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuFavorite"
        if segue.identifier == iden {
            let myMenuDetail = segue.destination as! MenuFavoriteDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].menu
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].ingredient
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].method
            let photoURL = currentPostData[tableView.indexPathForSelectedRow!.row].photoURL
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].category
            myMenuDetail.menu = name
            myMenuDetail.ingredient = ingredient
            myMenuDetail.method = method
            myMenuDetail.photoURL = photoURL
            myMenuDetail.keepCategory = category
        }
    }
}




