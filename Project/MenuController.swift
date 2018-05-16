//
//  MenuController.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var profileImage: UIImageView!
    var menuOptions = ["Home","MenuPopular","Menufromlike","InsertMenu","MenuFavourite","Calender","Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = 10
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
        profileImage.clipsToBounds = true
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        
        cell.optionName.text = menuOptions[indexPath.row]
        cell.optionImage.image = UIImage(named: menuOptions[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: menuOptions[indexPath.row], sender: self)
    }
    
   
}
