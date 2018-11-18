//
//  BreakfastDetail.swift
//  Project
//
//  Created by Pakaporn on 11/12/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class BreakfastDetail: BaseMenuController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var menuLabel: UILabel!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var category: UIPickerView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var menu = ""
    var ingredient = ""
    var method = ""
    var keepCategory = ""
    var photoURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        menuLabel.text = menu
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
        //        ImageService.getImage(withURL: photoURL) { image, url in
        //            self.imageView.image = image
        //        }
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
        return keepCategory
    }
}

