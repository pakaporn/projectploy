//
//  MenuPopularScreen.swift
//  Project
//
//  Created by Pakaporn on 10/5/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class MenuPopularScreen: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var postData = [MenuPopular]()
    var currentPostData = [MenuPopular]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuRef = Database.database().reference().child("menuPopular")
    var mymenu = [MenuPopular]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
        
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPostData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPopular Cell", for: indexPath) as! MenuPopularCell
        let menufood = currentPostData[indexPath.row]
        cell.menufood = menufood
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuPopular"
        if segue.identifier == iden {
            let myMenuDetail = segue.destination as! MenuPopularDetail
            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
            myMenuDetail.menu = name
            myMenuDetail.ingredient = ingredient
            myMenuDetail.method = method
        }
    }
    
    
}

