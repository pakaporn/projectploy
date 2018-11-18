//
//  MyMenuDetail.swift
//  Project
//
//  Created by Pakaporn on 9/25/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class MyMenuDetail: BaseMenuController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var category: UIPickerView!
//    @IBOutlet var ingredientTextView: UITextView!
//    @IBOutlet var methodTextView: UITextView!
//    @IBOutlet var imageView: UIImageView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var keepTaskNamee: String = ""
    
    let menuRef = Database.database().reference().child("post")
    var menu = ""
    var ingredient = ""
    var method = ""
    var uid = ""
    var id = ""
    var username = ""
    var uphotoURL: String = ""
    var photoURL: String = ""
    var timestamp: Double = 0
    var getCategory = ""
    var numberOfLikes = 0
    //var dummy:Post
    var keepData = [Post]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.reloadInputViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.reloadInputViews()
        imageView.image = nil
        setImage()
        menuLabel.text = menu
        ingredientTextView.text = ingredient
        methodTextView.text = method
        category.dataSource = self
        category.delegate = self
        getData()
//        ingredientTextView.text = ingredient
//        methodTextView.text = method
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.reloadInputViews()
        let iden = "EditMyMenu"
        if segue.identifier == iden {
            let editMyMenu = segue.destination as! EditMyMenu
            let menu = self.menu
            let ingredient = self.ingredient
            let method = self.method
            let photoURL = self.photoURL
            let category = self.getCategory
            let id = self.id
            editMyMenu.menu = menu
            editMyMenu.ingredient = ingredient
            editMyMenu.method = method
            editMyMenu.photoURL = photoURL
            editMyMenu.getCategory = category
            editMyMenu.id = id
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
    
    func getData() { //get autoByID
        Database.database().reference().child("posts").observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    var userKey = child.key as! String
                    let menufood = Post(snapshot: child)
                    self.keepData.insert(menufood, at: 0)
                    if self.keepData[0].menu == self.menu {
                        self.id = userKey
                    }
                }
            }
        })
    }
    
    
    @IBAction func gotoEdit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"EditMyMenu") as! EditMyMenu
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        SelectedKindOfFood = kindOfFood[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getCategory
    }
}


