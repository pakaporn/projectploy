//
//  MenuFavouriteDetail.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class MenuFavoriteDetail: BaseMenuController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuFav = Database.database().reference().child("menuFavorite")
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
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let iden = "SaveToCalender"
//        if segue.identifier == iden {
//            let saveToCalender = segue.destination as! SaveToCalenderScreen
//            
//        }
//    }
}



