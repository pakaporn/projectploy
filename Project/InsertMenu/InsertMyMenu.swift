//
//  InsertMyMenu.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class InsertMyMenu: BaseMenuController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var menuTextField: UITextField!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var category: UIPickerView!
    @IBOutlet var saveMenu: UIButton!
    @IBOutlet var camera: UIButton!
    
    var imagePicker: UIImagePickerController!
    var SelectedKindOfFood = "แกง"
    let kindOfFood = ["แกง","ผัด","ต้ม","ทอด","อบ-ตุ๋น","นึ่ง","ยำ","น้ำพริก"]
    @IBAction func handlePostButton() {
        guard let image = imageView.image else { return }
        guard let userProfile = UserService.currentUserProfile else { return }
        self.uploadProfileImage(image) { url in
        // Firebase code here
        let postRef = Database.database().reference().child("posts").childByAutoId()
        let postObject = [
            "User": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "menu": self.menuTextField.text ?? "",
            "ingredient": self.ingredientTextView.text,
            "method": self.methodTextView.text,
            "kindOFfood": self.SelectedKindOfFood,
            "photoURL": url?.absoluteString ?? "",
            "numberOfLikes": 0,
            "timestamp": [".sv":"timestamp"]
            ] as [String:Any]

        print(postObject)
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
        }
    }
    
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
        category.dataSource = self
        category.delegate = self
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        saveMenu.layer.cornerRadius = saveMenu.bounds.height/6
        imageView.layer.cornerRadius = imageView.bounds.height / 8
        imageView.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("\(menuTextField.text!)")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
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

