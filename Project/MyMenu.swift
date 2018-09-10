//
//  StoriesTableViewController.swift
//  UITableViewDemo
//
//  Created by Duc Tran on 2/24/16.
//  Copyright © 2016 Developers Academy. All rights reserved.
//

import UIKit
import Firebase

enum selectedScopeMyMenu: Int {
    case ingredients = 0
    case category = 1
}

class MyMenu: UITableViewController , UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var postData = [MenuDetail]()
    var currentPostData = [MenuDetail]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    // 1. create a reference ot the db location you want to download
    let menuRef = Database.database().reference().child("mymenu")
    var mymenu = [MenuDetail]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            self.mymenu.removeAll()
            
            if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = MenuDetail(snapshot: childSnapshot)
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
        title = "เมนูอาหาร"
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Item", style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func searchBarSetUp(){
        let searchBar = UISearchBar(frame: CGRect(x: 0,y: 0,width:(UIScreen.main.bounds.width),height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["วัตถุดิบ", "ประเภทอาหาร"]
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
        case selectedScopeMyMenu.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getName().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScopeMyMenu.category.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getName().lowercased().contains(text.lowercased())
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath) as! MyMenuCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MyMenuDetail"
        if segue.identifier == iden {
            let myMenuDetail = segue.destination as! MyMenuDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            myMenuDetail.text = name
            myMenuDetail.ingredient = ingredient
            myMenuDetail.method = method
        }
    }
    
}


