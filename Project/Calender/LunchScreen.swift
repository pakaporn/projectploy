//
//  LunchScreen.swift
//  Project
//
//  Created by Pakaporn on 11/12/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class LunchScreen: UITableViewController, UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postData = [MenuCalender]()
    var currentPostData = [MenuCalender]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var date = ""
    var meal = "Lunch"
    let menuRef = Database.database().reference().child("menuCalendar")
    var mymenu = [MenuCalender]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menuRef.observe(.value, with: { (snapshot) in
            //self.menu.removeAll()
            
            if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = MenuCalender(snapshot: childSnapshot)
                    //self.menu.insert(menufood, at: 0)
                    if menufood.date == self.date && menufood.meals == self.meal {
                        self.postData.append(menufood)
                        self.currentPostData = self.postData
                        self.tableView.reloadData()
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBarSetUp()
        //print(self.id)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        title = "Lunch of this day"
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func searchBarSetUp() {
        let searchBar = UISearchBar(frame: CGRect(x: 0,y: 0, width:(UIScreen.main.bounds.width), height: 70))
        //searchBar.placeholder = "ค้นหาโดยชื่อเมนูอาหาร"
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["ค้นหาโดยชื่อเมนูอาหาร", "ค้นหาโดยวัตถุดิบ"]
        //searchBar.barTintColor = UIColor.blue
        searchBar.selectedScopeButtonIndex = 0
        if searchBar.selectedScopeButtonIndex == 0 {
            searchBar.placeholder = "ค้นหาโดยชื่อเมนูอาหาร"
        } else {
            searchBar.placeholder = "ค้นหาโดยวัตถุดิบ"
        }
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
                return mod.category.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPostData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lunch Cell", for: indexPath) as! LunchCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LunchDetail"
        if segue.identifier == iden {
            let myMenuDetail = segue.destination as! LunchDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].category
            let photoURL = currentPostData[tableView.indexPathForSelectedRow!.row].photoURL
            myMenuDetail.menu = name
            myMenuDetail.ingredient = ingredient
            myMenuDetail.method = method
            myMenuDetail.keepCategory = category
            myMenuDetail.photoURL = photoURL
        }
    }
}

