//
//  SelectMenuDetail.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class SelectMenuDetail: BaseMenuController {
    
    private let dataSource: [String] = ["ต้ม","แกง","ผัด","ตำ","ทอด"]
    var keepType = "";
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var selectButton: UIButton!
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
    var keepIngredientSelected = [String]()
    var keepMenuSelected = [Menu]()
    var keepNoIngredient = [String]()
    //    var menufood: Menu! {
    //        didSet {
    //            menuLabel.text = menufood.text
    //            ingredientTextView.text = menufood.ingredient
    //            methodTextView.text = menufood.method
    //
    //        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var holdNoIngredient = [String]()
                for ingredientMain in ingredientTextView.text.split(separator: " "){
            for ingredientKeep in keepIngredientSelected {
                if ingredientKeep != ingredientMain {
                    holdNoIngredient.append(String(ingredientMain))
                }
            }
        }
        var keepIndexToRemove = [Int]()
        if holdNoIngredient.count > 0 {
            for count in 0...holdNoIngredient.count-1 {
                for ingredientKeep in keepIngredientSelected {
                    if holdNoIngredient[count] == ingredientKeep {
                        keepIndexToRemove.append(count)
                    }
                }
            }
        }
        
        keepIndexToRemove = keepIndexToRemove.sorted { $0 > $1 }
        if keepIndexToRemove.count > 0 {
            for num in 0...keepIndexToRemove.count-1 {
                holdNoIngredient.remove(at: keepIndexToRemove[num])
            }
        }
        
        var keepF = [Int]()
        var keepS = [Int]()
        if holdNoIngredient.count > 0 {
            for index in 0...holdNoIngredient.count-1 {
                for indexIn in 0...index{
                    if index != indexIn {
                        if holdNoIngredient[index] == holdNoIngredient[indexIn] {
                            keepF.append(index)
                            keepS.append(indexIn)
                        }
                    }
                }
            }
        }
        
        if keepF.count > 0 {
            for num in 0...keepF.count-1{
                holdNoIngredient.remove(at: keepF[num])
                //print(holdNoIngredient)
            }
        }
        for noIngredient in holdNoIngredient {
            keepNoIngredient.append(noIngredient)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLabel.text = text
        ingredientTextView.text = ingredient
        methodTextView.text = method
//        category.dataSource = self
//        category.delegate = self
        ingredientTextView.layer.borderWidth = 2
        ingredientTextView.layer.borderColor = UIColor.gray.cgColor
        methodTextView.layer.borderWidth = 2
        methodTextView.layer.borderColor = UIColor.gray.cgColor
        category.layer.borderWidth = 2
        category.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        selectButton.layer.cornerRadius = selectButton.bounds.height/2
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "BackSelectMenu"
        if segue.identifier == iden {
            let selectMenu = segue.destination as! SelectMenu
            selectMenu.keepIngredient = keepIngredientSelected
            selectMenu.keepNoIngredient = keepNoIngredient
            
        }
    }
    
    @IBAction func saveSelectMenu(_ sender: UIButton){
//        let selectMenu = Database.database().reference().child("menuFavorite")
//        let key = selectMenu.childByAutoId().key
//        let menuFavorite = ["id": key, "menu": menuLabel.text! as String, "ingredient": ingredientTextView.text! as String, "method": methodTextView.text! as String, "category": category.dataSource! as! String ]
//        //,"category": categoryTextView.text! as String
//        selectMenu.child(key).setValue(menuFavorite)
    }
}

extension SelectMenuDetail: UIPickerViewDelegate, UIPickerViewDataSource {
    
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


