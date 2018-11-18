//
//  SelectMenu.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

enum selectedScopeSelectMenu: Int {
    case name = 0
    case ingredients = 1
    case category = 2
}

class SelectMenu: UITableViewController, UISearchBarDelegate, UITextViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postData = [Menu]()
    var currentPostData = [Menu]()
    var currentData = [Menu]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var keepIngredient = [String]()
    var keepMenu = [Menu]()
    var keepDataFilter = [Substring]()
    var keepNoIngredient = [String]()
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
                    //print(self.menu[0].getIngredient())
                    self.postData.append(menufood)
                    self.currentPostData = self.postData
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetUp()
        print(keepIngredient)
        print(keepNoIngredient)
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
        let searchBar = UISearchBar(frame: CGRect(x: 0,y: 0, width:(UIScreen.main.bounds.width), height: 70))
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
        }
        self.tableView.reloadData()
    }
    
    func filterTableView(ind: Int, text: String){
        switch ind {
        case selectedScope.name.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getName().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScope.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.getIngredient().lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryBuy Cell", for: indexPath) as! SelectMenuCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SelectMenu"
        let idenIngredient = "Ingredient"
        let idenBackIngredient = "BackSelectMenu"
        if segue.identifier == iden {
            let selectMenuDetail = segue.destination as! SelectMenuDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].getCategory()
            //keepMenu.append(currentPostData[tableView.indexPathForSelectedRow!.row])
            //selectMenu.keepMenuSelected = keepMenu
            selectMenuDetail.text = name
            selectMenuDetail.ingredient = ingredient
            selectMenuDetail.method = method
            selectMenuDetail.keepCategory = category
            selectMenuDetail.keepIngredientSelected = keepIngredient
            selectMenuDetail.keepNoIngredient = keepNoIngredient
        } else if segue.identifier == idenIngredient {
            let ingredientScreen = segue.destination as! IngredientScreen
            for menu in keepMenu {
                if menu.getIngredient().split(separator: " ").count > 0 {
                    for ingredient in 0...menu.getIngredient().split(separator: " ").count-1 {
                        
                    }
                }
            }
        }
    }
}


