//
//  SearchMenu.swift
//  Project
//
//  Created by Pakaporn on 5/17/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class SearchMenu: BaseMenuController {
    
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
    var photoURL = ""
    var timestamp: Double = 0
    var numberOfLikes = 0
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
        setImage()
        menuLabel.text = text
        ingredientTextView.text = ingredient
        methodTextView.text = method
        category.dataSource = self
        category.delegate = self
        ingredientTextView.layer.borderWidth = 2
        ingredientTextView.layer.borderColor = UIColor.gray.cgColor
        methodTextView.layer.borderWidth = 2
        methodTextView.layer.borderColor = UIColor.gray.cgColor
        category.layer.borderWidth = 2
        category.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        favoriteButton.layer.borderWidth = 2
        favoriteButton.layer.borderColor = UIColor.gray.cgColor
        favoriteButton.layer.cornerRadius = favoriteButton.bounds.height/2
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
        let menuFavorite = ["id": key,
                            "menu": menuLabel.text! as String,
                            "ingredient": ingredientTextView.text! as String,
                            "method": methodTextView.text! as String,
                            "category": keepCategory as! String,
                            "numberOfLikes": numberOfLikes as Int,
                            "photoURL": photoURL as String,
                            "timestamp": timestamp as Double
            ] as [String : Any]
        //,"category": categoryTextView.text! as String
        menuFav.child(key).setValue(menuFavorite)
    }
    
    func setImage() {
        view.reloadInputViews()
        let imageStorageRef = Storage.storage().reference(forURL: photoURL)
        imageStorageRef.getData(maxSize: 2 * 1024 * 1024, completion: { [weak self] (data, error) in
            
            if let error = error {
                print("Download Photo Error")
            }else {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self?.imageView.image = image
                }
            }
        })
        //        ImageService.getImage(withURL: photoURL) { image, url in
        //            self.imageView.image = image
        //        }
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

