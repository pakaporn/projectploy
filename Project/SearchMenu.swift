//
//  SearchMenu.swift
//  Project
//
//  Created by Pakaporn on 5/17/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class SearchMenu: BaseMenuController  {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuRef = Database.database().reference().child("menu")
    var text = ""
    var ingredient = ""
    var method = ""
    
//    var menufood: Menu! {
//        didSet {
//            menuLabel.text = menufood.text
//            ingredientTextView.text = menufood.ingredient
//            methodTextView.text = menufood.method
//
//        }
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.text = text
        ingredientTextView.text = ingredient
        methodTextView.text = method
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    
}

