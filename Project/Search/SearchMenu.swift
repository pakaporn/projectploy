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
    
    private let dataSource: [String] = ["ต้ม","แกง","ผัด","ตำ","ทอด"]
    var keepType = "";
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var imageView: UIImageView!
   // @IBOutlet var category: UIPickerView!
    @IBOutlet weak var category: UIPickerView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuRef = Database.database().reference().child("menu")
    var text = ""
    var ingredient = ""
    var method = ""
    var keepCategory = ""
    var keepStartValue = 0
    var countCategoryFor = 0
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
        category.dataSource = self
        category.delegate = self
        for category in dataSource {
            
            if category == keepCategory {
                keepStartValue = countCategoryFor
            }
            countCategoryFor += 1
            print(keepStartValue)
        }
        
        category.selectRow(keepStartValue, inComponent: 0, animated: true)
    //  categoryTextView.text = category  wait for create in Main.story board
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func saveFavorite(_ sender: UIButton){
        let menuFav = Database.database().reference().child("menuFavorite")
        let key = menuFav.childByAutoId().key
        let menuFavorite = ["id": key, "menu": menuLabel.text! as String, "ingredient": ingredientTextView.text! as String, "method": methodTextView.text! as String,"category": category.dataSource! as! String ]
        //,"category": categoryTextView.text! as String
        menuFav.child(key).setValue(menuFavorite)
    }
    
}

extension SearchMenu: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        keepType = dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        for category in dataSource {
//            if keepCategory == category {
//                return keepCategory
//            }
//        }
        return dataSource[row]
    }
    
}

