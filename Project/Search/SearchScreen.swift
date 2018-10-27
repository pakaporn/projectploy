//
//  StoriesTableViewController.swift
//  UITableViewDemo
//
//  Created by Duc Tran on 2/24/16.
//  Copyright © 2016 Developers Academy. All rights reserved.
///

import UIKit
import Firebase

enum selectedScope: Int {
    case name = 0
    case ingredients = 1
    case category = 2
}

class SearchScreen: UITableViewController , UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var postData = [Menu]()
    var currentPostData = [Menu]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    // 1. create a reference ot the db location you want to download
    let menuRef = Database.database().reference().child("menu")
    var menu = [Menu]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            self.menu.removeAll()
            
            if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = Menu(snapshot: childSnapshot)
                    self.menu.insert(menufood, at: 0)
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
    
        //ref?.child("menu").queryLimited(toLast: 10)//queryOrdered(byChild: "text")
        //
        //        DataService.ds.MSGS_DB_REF.queryOrdered(byChild: "text").observe(.value) { (snapshot) in
        //            self.menu = [Menu]()
        //
        //            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
        //                for snap in snapshot {
        //                    if (snap.value as? [String: AnyObject]) != nil {
        //                        let message = Menu(text: snap.key, ingredient: snap.key, method: snap.key)
        //                        self.menu.append(message)
        //
        //                    }
        //                }
        //                self.tableView.reloadData()
        //            }
        //        }
        self.searchBarSetUp()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        title = "เมนูอาหาร"
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func searchBarSetUp(){
        let searchBar = UISearchBar(frame: CGRect(x: 0,y: 0,width:(UIScreen.main.bounds.width),height: 70))
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
        }else{
            filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
        }
        self.tableView.reloadData()
        
    }
    
    func filterTableView(ind: Int, text: String){
        switch ind  {
        case selectedScope.name.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getName().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind  {
        case selectedScope.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getIngredient().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind  {
        case selectedScope.category.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getCategory().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // TODO: return the stories count
        return currentPostData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Story Cell", for: indexPath) as! SearchScreenCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SearchMenu"
        if segue.identifier == iden {
            let searchMenu = segue.destination as! SearchMenu
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].getCategory()
            searchMenu.text = name
            searchMenu.ingredient = ingredient
            searchMenu.method = method
            searchMenu.keepCategory = category
        }
    }
}



