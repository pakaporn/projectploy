//
//  MenuPopularDetail.swift
//  Project
//
//  Created by Pakaporn on 10/5/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//


import UIKit
import Firebase

class MenuPopularDetail: BaseMenuController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuFav = Database.database().reference().child("menuPopular")
    var menu = ""
    var ingredient = ""
    var method = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.text = menu
        ingredientTextView.text = ingredient
        methodTextView.text = method
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    
}

