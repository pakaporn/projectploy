//
//  SearchByCheckList.swift
//  Project
//
//  Created by Pakaporn on 9/23/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

//enum selectedScope: Int {
//    case name = 0
//    case ingredients = 1
//    case category = 2
//}

class SearchByCheckList: UITableViewController, UISearchBarDelegate, UITextViewDelegate {
    
    var keepTaskNamee : [String] = []
    var realCurrentData : [Menu] = []
    var keepDataFilter = [Substring]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postData = [Post]()
    var currentPostData = [Post]()
    var ref: DatabaseReference?
    let menuRef = Database.database().reference().child("posts")
    var menu = [Post]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            self.menu.removeAll()
            
            if self.currentPostData.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = Post(snapshot: childSnapshot)
                    self.menu.insert(menufood, at: 0)
                    self.keepDataFilter = []
                    for ingredient in self.menu[0].getIngredient().split(separator: " "){
                        self.keepDataFilter.append(ingredient)
                    }
                    for ingredientSelected in self.keepTaskNamee{
                        for ingredientMain in self.keepDataFilter{
                            if ingredientSelected == ingredientMain {
                                self.postData.append(menufood)
                                self.currentPostData = self.postData
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                var keepF = [Int]()
                var keepS = [Int]()
                if self.currentPostData.count > 0 {
                    for index in 0...self.currentPostData.count-1 {
                        for indexIn in 0...index{
                            if index != indexIn {
                                if self.currentPostData[index].menu == self.currentPostData[indexIn].menu {
                                    keepF.append(index)
                                    keepS.append(indexIn)
                                }
                            }
                        }
                    }
                }
                if keepF.count > 0 {
                    for num in 0...keepF.count-1{
                        self.currentPostData.remove(at: keepF[num])
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func searchBarSetUp() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width:(UIScreen.main.bounds.width), height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["ค้นหาโดยชื่อเมนูอาหาร", "ค้นหาโดยวัตถุดิบ"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.placeholder = "ค้นหา"
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
        switch ind  {
        case selectedScope.name.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.menu.lowercased().contains(text.lowercased())
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Story CheckList", for: indexPath) as! SearchByCheckListCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SearchCheckList"
        if segue.identifier == iden {
            let searchCheckList = segue.destination as! SearchByCheckListDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].menu
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].kindOFfood
            let photoURL = currentPostData[tableView.indexPathForSelectedRow!.row].photoURL
            searchCheckList.menu = name!
            searchCheckList.ingredient = ingredient
            searchCheckList.method = method
            searchCheckList.keepCategory = category!
            searchCheckList.photoURL = photoURL!
        }
    }
}
