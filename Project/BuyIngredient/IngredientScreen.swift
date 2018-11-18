//
//  IngredientScreen.swift
//  Project
//
//  Created by Pakaporn on 11/7/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class IngredientScreen: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryIngredirnt Cell", for: indexPath) as! IngredientCell
        //let menufood = currentPostData[indexPath.row]
        // cell.menufood = menufood
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let iden = "SelectMenu"
//        if segue.identifier == iden {
//            let searchMenu = segue.destination as! SelectMenuDetail
//            let name = currentPostData[tableView.indexPathForSelectedRow!.row].getName()
//            let ingredient = currentPostData[tableView.indexPathForSelectedRow!.row].getIngredient()
//            let method = currentPostData[tableView.indexPathForSelectedRow!.row].getMethod()
//            let category = currentPostData[tableView.indexPathForSelectedRow!.row].getCategory()
//            searchMenu.text = name
//            searchMenu.ingredient = ingredient
//            searchMenu.method = method
//            searchMenu.keepCategory = category
//        }
//    }

}
