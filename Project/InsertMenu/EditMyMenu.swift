//
//  EditMyMenu.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class EditMyMenu: BaseMenuController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var menuTextField: UITextField!
    @IBOutlet var likebutton: UIButton!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet var camera: UIButton!
    @IBOutlet var updateMenu: UIButton!
    
    var ref: DatabaseReference?
    var newRef = Database.database().reference().childByAutoId().child("myMenu")
    var databaseHandle: DatabaseHandle?
    var numberOfLikes = 0
    let menuRef = Database.database().reference().child("mymenu")
    var imagePicker: UIImagePickerController!
    var menu = ""
    var ingredient = ""
    var method = ""
    var id = ""
    var getCategory = ""
    var photoURL = ""
    var SelectedKindOfFood = ""
    let kindOfFood = ["แกง","ผัด","ต้ม","ทอด","อบ-ตุ๋น","นึ่ง","ยำ","น้ำพริก"]
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func openImagePicker(_ sender: Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SelectedKindOfFood = self.getCategory
        setImage()
        menuTextField.text = menu
        ingredientTextView.text = ingredient
        methodTextView.text = method
        category.dataSource = self
        category.delegate = self
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

//        ref = Database.database().reference().child("mymenu");
//        self.navigationController?.hidesBarsOnSwipe = true
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    @IBAction func saveMymenu() {
        addMymenu()
//        let vc = self.storyboard?.instantiateViewController(withIdentifier:"Detail") as! MyMenuDetail
//        self.present(vc, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func dismiss() {
//        navigationController?.popViewController(animated: true)
//    }

    func addMymenu() {
        guard let image = imageView.image else { return }
        //guard let userProfile = UserService.currentUserProfile else { return }
        self.uploadImage(image) { url in
            if url != nil {
                let myMenu = [
                    "menu": self.menuTextField.text!,
                    "ingredient": self.ingredientTextView.text,
                    "method": self.methodTextView.text,
                    "kindOFfood": self.SelectedKindOfFood,
                    "photoURL": url?.absoluteString,
                    ] as [String:Any]
                Database.database().reference().child("posts").child(self.id).updateChildValues(myMenu)
            }else {
                let myMenu = [
                    "menu": self.menuTextField.text!,
                    "ingredient": self.ingredientTextView.text,
                    "method": self.methodTextView.text,
                    "kindOFfood": self.SelectedKindOfFood,
                    ] as [String:Any]
                Database.database().reference().child("posts").child(self.id).updateChildValues(myMenu)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?)->())) {
        let storageRef = Storage.storage().reference().child("photoURL")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }

    func setImage() {
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
        return kindOfFood.count
    }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            SelectedKindOfFood = kindOfFood[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kindOfFood[row]
    }
}
