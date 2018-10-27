//
//  EditMyMenu.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class EditMyMenu: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet var menuTextField: UITextField!
    @IBOutlet var likebutton: UIButton!
    @IBOutlet var ingredientTextView: UITextView!
    @IBOutlet var methodTextView: UITextView!
    //@IBOutlet var saveMymenu: UIButton!
    
    var ref: DatabaseReference?
    var newRef = Database.database().reference().childByAutoId().child("myMenu")
    var databaseHandle: DatabaseHandle?
    var numberOfLikes = 0
    let menuRef = Database.database().reference().child("mymenu")
    var text = ""
    var ingredient = ""
    var method = ""
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTextField.text = text
        ingredientTextView.text = ingredient
        methodTextView.text = method
//        ref = Database.database().reference().child("mymenu");
//        self.navigationController?.hidesBarsOnSwipe = true
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    @IBAction func saveMymenu(_sender: UIButton) {
        addMymenu()
    }

    func addMymenu() {
        //let key = ref?.child("mymenu").child(id)
        let myMenu = [
                      "text": menuTextField.text! as String,
                      "numberOfLikes": numberOfLikes as Int,
                      "ingredient": ingredientTextView.text! as String,
                      "method": methodTextView.text! as String] as [String : Any]
        //let childUpdate = ["/mymenu/\(key)": myMenu,
        //                                       "/user-posts/\(id)/\(key)/": myMenu]
        //ref?.child(key!).setValue(myMenu)
        Database.database().reference().child("mymenu").child(id).updateChildValues(myMenu)
      //  Database.database().reference().child("mymenu").child(id).child(ingredient).setValue(ingredientTextView.text!)
       // Database.database().reference().child("mymenu").child(id).child(method).setValue(methodTextView.text!)
        //print(id)
        //print(Database.database().reference().child("mymenu").child(id)) //child(text)
        //print(ref?.child("mymenu").child(id)
        //print(menuTextField.text!)
        navigationController?.popViewController(animated: true)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let iden = "EditMyMenu"
//        if segue.identifier == iden {
//            let editMyMenu = segue.destination as! EditMyMenu
//        }
//    }
    
}

//let key = ref.child("posts").childByAutoId().key
//let post = ["uid": userID,
//            "author": username,
//            "title": title,
//            "body": body]
//let childUpdates = ["/posts/\(key)": post,
//                    "/user-posts/\(userID)/\(key)/": post]
//ref.updateChildValues(childUpdates)











    

    


