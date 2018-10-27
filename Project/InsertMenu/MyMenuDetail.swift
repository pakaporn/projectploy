//
//  MyMenuDetail.swift
//  Project
//
//  Created by Pakaporn on 9/25/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class MyMenuDetail: BaseMenuController  {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var menuLabel: UILabel!
//    @IBOutlet var ingredientTextView: UITextView!
//    @IBOutlet var methodTextView: UITextView!
//    @IBOutlet var imageView: UIImageView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var keepTaskNamee: String = ""
    
    let menuRef = Database.database().reference().child("post")
    var text = ""
    var ingredient = ""
    var method = ""
    var id = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.text = text
//        ingredientTextView.text = ingredient
//        methodTextView.text = method
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "EditMyMenu"
        if segue.identifier == iden {
            let EditMyMenu = segue.destination as! EditMyMenu
            let name = text
            let ingredient = self.ingredient
            let method = self.method
            let id = self.id
            EditMyMenu.text = name
            EditMyMenu.ingredient = ingredient
            EditMyMenu.method = method
            EditMyMenu.id = id
        }
    }
}


