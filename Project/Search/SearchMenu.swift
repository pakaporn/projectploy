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
    var checkFamilar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                Database.database().reference().child("menuFavorite").observe(.value, with: { (snapshot) in
                    if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        for child in result {
                            let menufood = MenuFavorite(snapshot: child)
                            if menufood.getName() == self.text && menufood.uid == user!.uid{
                                self.checkFamilar = true
                            }
                        }
                    }
                })
            }
        }
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
    
//    func set() {
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil {
//                //if user?.photoURL != nil {
//                ImageService.getImage(withURL: (user?.photoURL)!  ) { image, url in
//                    self.profileImage.image = image
//                }
//                //}
//                self.userName.text = user?.displayName
//            }
//        }
//    }

    
    @IBAction func saveFavorite(_ sender: UIButton){
        let menuFav = Database.database().reference().child("menuFavorite")
        let key = menuFav.childByAutoId().key
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
                if self.checkFamilar == false{
                    let menuFavorite = ["id": key,
                                        "uid": user!.uid,
                                        "menu": self.menuLabel.text! as String,
                                        "ingredient": self.ingredientTextView.text! as String,
                                        "method": self.methodTextView.text! as String,
                                        "category": self.keepCategory as! String,
                                        "numberOfLikes": self.numberOfLikes as Int,
                                        "photoURL": self.photoURL as String,
                                        "timestamp": self.timestamp as Double
                        ] as [String : Any]
                    menuFav.child(key).setValue(menuFavorite)
                    
                    let alert = UIAlertController(title: "Success!", message: "This menu has added to your favorite menu.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Fail!", message: "This menu has added in your favorite menu.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "Attention !", message: "You need to login first.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
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

