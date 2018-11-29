//
//  SearchByCheckListDetail.swift
//  Project
//
//  Created by Pakaporn on 10/28/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class SearchByCheckListDetail: BaseMenuController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var category: UIPickerView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    let menuFav = Database.database().reference().child("menu")
    var menu = ""
    var ingredient = ""
    var method = ""
    var keepCategory = ""
    var photoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        category.dataSource = self
        category.delegate = self
        menuLabel.text = menu
        ingredientTextView.text = ingredient
        methodTextView.text = method
        ingredientTextView.layer.borderWidth = 2
        ingredientTextView.layer.borderColor = UIColor.gray.cgColor
        methodTextView.layer.borderWidth = 2
        methodTextView.layer.borderColor = UIColor.gray.cgColor
        category.layer.borderWidth = 2
        category.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        self.navigationController?.hidesBarsOnSwipe = true
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
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return keepCategory
    }
}

