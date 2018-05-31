//
//  SearchScreen.swift
//  Project
//
//  Created by Pakaporn on 5/28/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum selectedScope: Int {
    case ingredients = 0
    case category = 1
}

class SearchScreen: BaseMenuController, UISearchBarDelegate, UITextViewDelegate, UITableViewDataSource  {
    

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    let cellidentifier = "Cell"
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var postData = [String]()
    var currentPostData = [String]()
    
    @IBAction func compose(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetUp()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellidentifier)
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)
                self.currentPostData = self.postData
                self.tableView.reloadData()
            }
        })
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
        case selectedScope.ingredients.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.category.rawValue:
            currentPostData = postData.filter({ (mod) -> Bool in
                return mod.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Data")
        }
        
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier,for: indexPath)
        cell.textLabel!.text = currentPostData[indexPath.row]
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "Search"
        if segue.identifier == iden {
            let searchScreen = segue.destination as! SearchScreen
        }
    }
    
}





    


    
    
