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

class SelectMenu: UITableViewController, UISearchBarDelegate, UITextViewDelegate, AddTask, CheckBox {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var postData = [Post]()
    var keepPostData = [KeepPost]()
    var currentPostData = [Post]()
    var currentData = [Post]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var keepIngredient = [String]()
    var keepMenu = [Post]()
    var keepDataFilter = [Substring]()
    var keepNoIngredient = [String]()
    var keepKeepPost = [KeepPost]()
    var keepPost = [Post]()
    // 1. create a reference ot the db location you want to download
    let menuRef = Database.database().reference().child("posts")
    var menu = [Post]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            self.menu.removeAll()
            
            if self.keepKeepPost.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = Post(snapshot: childSnapshot)
                    self.menu.insert(menufood, at: 0)
                    //print(self.menu[0].getIngredient())
                    self.keepPostData.append(KeepPost(name: menufood))
                    self.keepKeepPost = self.keepPostData
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
        })
        
        Database.database().reference().child("keepIngredient").observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let menufood = KeepIngredientForBuy(snapshot: child)
                    print(menufood.keepIngredient)
                    for name in menufood.keepIngredient {
                        print(name)
                        self.keepIngredient.append(name)
                    }
                }
            }
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
            keepKeepPost = keepPostData
            self.tableView.reloadData()
        } else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex,text: searchText)
        }
        self.tableView.reloadData()
    }
    
    func filterTableView(ind: Int, text: String){
        switch ind {
        case selectedScope.name.rawValue:
            keepKeepPost = keepPostData.filter({ (mod) -> Bool in
                return mod.postName.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScope.ingredients.rawValue:
            keepKeepPost = keepPostData.filter({ (mod) -> Bool in
                return mod.postIngredient.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
        switch ind {
        case selectedScope.category.rawValue:
            keepKeepPost = keepPostData.filter({ (mod) -> Bool in
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // TODO: return the stories count
        return keepKeepPost.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryBuy Cell", for: indexPath) as! SelectMenuCell
        cell.storyLabel.text = keepKeepPost[indexPath.row].postName
        if keepKeepPost[indexPath.row].checkedIngredient {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
            keepPost.append(keepKeepPost[indexPath.row].post!)
            print(keepPost)
        }else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
            if keepPost.count > 0 {
                var at = 0
                for name in 0...keepPost.count-1 {
                    if keepPost[name].menu == keepKeepPost[indexPath.row].postName {
                        at = name
                    }
                }
                keepPost.remove(at: at)
                print(keepPost)
            }
        }
        cell.delegate = self 
        cell.ingredients = keepKeepPost
        cell.indexP = indexPath.row
//        let menufood = currentPostData[indexPath.row]
//        cell.menufood = menufood
        return cell
    }
    
    
    

//        if ingredients[indexPath.row].checkedIngredient {
//            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
//            keepTaskName.append(ingredients[indexPath.row].nameIngredient)
//            print(keepTaskName)
//        } else {
//            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
//            if(keepTaskName.count > 0) {
//                var at = 0
//                for name in 0...keepTaskName.count-1 {
//                    if keepTaskName[name] == ingredients[indexPath.row].nameIngredient {
//                        at = name
//                    }
//                }
//                keepTaskName.remove(at: at)
//                print(keepTaskName)
//            }
//        }
//        cell.delegate = self
//        cell.ingredients = ingredients
//        cell.indexP = indexPath.row
//        return cell
//    }

    
    func addTask(name: String) {
        menuRef.observe(.value, with: { (snapshot) in            
            if self.keepKeepPost.count == 0 { //เช็คว่าถ้าไม่มีค่าใน currentPostData  จะโหลดข้อมูลจาก firebase
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    let menufood = Post(snapshot: childSnapshot)
                    self.keepPostData.append(KeepPost(name: menufood))
                    self.keepKeepPost = self.keepPostData
                }
            }
        })
        tableView.reloadData()
    }
    
    func checkBox(state: Bool, index: Int?) {
        keepKeepPost[index!].checkedIngredient = state
        tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.none)
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SelectMenu"
        let idenIngredient = "Ingredient"
        let idenFridge = "fridge"
        //let idenBackIngredient = "BackSelectMenu"
        if segue.identifier == iden {
            let selectMenuDetail = segue.destination as! SelectMenuDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].menu
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            let category = currentPostData[tableView.indexPathForSelectedRow!.row].kindOFfood
            //keepMenu.append(currentPostData[tableView.indexPathForSelectedRow!.row])
            //selectMenu.keepMenuSelected = keepMenu
            selectMenuDetail.text = name!
            selectMenuDetail.ingredient = ingredient
            selectMenuDetail.method = method
            selectMenuDetail.keepCategory = category!
            selectMenuDetail.keepIngredientSelected = keepIngredient
            selectMenuDetail.keepNoIngredient = keepNoIngredient
        } else if segue.identifier == idenIngredient {
            let ingredientScreen = segue.destination as! IngredientScreen
            //print(self.keepNoIngredient)
            for name in self.keepPost {  //ข้อมูลเมนู
                print(name.getMenuName())
            }
            var holdNoIngredient = [String]()
            print(self.keepIngredient)
            for menu in self.keepPost {
                if menu.getIngredient().split(separator: " ").count > 0 {
                    for index in 0...menu.getIngredient().split(separator: " ").count-1 {
                        for ingredient in self.keepIngredient {
                            if menu.ingredient.split(separator: " ")[index] != ingredient {
                                holdNoIngredient.append(String(menu.ingredient.split(separator: " ")[index]))
                            }
                        }
                    }
                }
            }
            
            self.keepNoIngredient = Array(Set(holdNoIngredient))
            ingredientScreen.getIngredient = self.keepNoIngredient
        }
    }
}

class KeepPost {
    
    var post:Post? = nil
    var postName = ""
    var postIngredient = ""
    var kindOFfood = ""
    var checkedIngredient = false
    
    convenience init (name: Post) {
        self.init()
        self.post = name
        self.postName = (post?.menu)!
        self.postIngredient = (post?.ingredient)!
        self.kindOFfood = (post?.kindOFfood)!
    }
}



