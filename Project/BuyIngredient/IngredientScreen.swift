//
//  IngredientScreen.swift
//  Project
//
//  Created by Pakaporn on 11/7/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class IngredientScreen: UITableViewController {
    
    var getIngredient = [String]()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getIngredient)
        print("On your way dude")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons25"), style: UIBarButtonItemStyle.plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 240
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
        return getIngredient.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryIngredirnt Cell", for: indexPath) as! IngredientCell
        let menufood = getIngredient[indexPath.row]
        cell.storyLabel.text = menufood
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
