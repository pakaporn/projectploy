//
//  BuyIngredientScreen.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//
import UIKit
import Firebase

class BuyIngerdientScreen: BaseMenuController, UITableViewDelegate, UITableViewDataSource, AddTask, CheckBox {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    let menuRef = Database.database().reference().child("keepIngredient")
    var userName = ""
    var userId = ""
    var id = ""
    var firstTime = true
    var postKeepIngredient = [KeepIngredientForBuy]()
    var keepIngredient = [KeepIngredientForBuy]()
    var keepForCell = [String]()
    let buyIngredientImageView: [UIImage] = [
        UIImage(named: "chicken")!,
        UIImage(named: "chop")!,
        UIImage(named: "fish")!,
        UIImage(named: "beef")!,
        UIImage(named: "egg")!,
        UIImage(named: "egg")!,
        UIImage(named: "chili")!,
        UIImage(named: "lemon")!,
        UIImage(named: "spinach")!,
        UIImage(named: "carrot")!,
        UIImage(named: "cabbage")!,
        UIImage(named: "mushroom")!,
        UIImage(named: "courgette")!,
        UIImage(named: "yogurt")!,
        UIImage(named: "milk")!
    ]
    
    var ingredients: [Ingredient] = [Ingredient(name: "ไก่"), Ingredient(name: "หมู"), Ingredient(name: "ปลา"), Ingredient(name: "เนื้อวัว"), Ingredient(name: "ไข่ไก่"), Ingredient(name: "ไข่เป็ด"), Ingredient(name: "พริก"), Ingredient(name: "มะนาว"), Ingredient(name: "ใบกระเพรา"), Ingredient(name: "แครอท"), Ingredient(name: "กะหล่ำปลี"), Ingredient(name: "เห็ด"), Ingredient(name: "แตงกวา"), Ingredient(name: "โยเกิร์ต"), Ingredient(name: "นม")]
    var keepTaskName: [String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let userProfile = UserService.currentUserProfile else { return }
        userName = userProfile.getUsername()
        userId = userProfile.getUid()
        // download menu
        menuRef.observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let menufood = KeepIngredientForBuy(snapshot: child)
                    self.postKeepIngredient.insert(menufood, at: 0)
                    if self.postKeepIngredient[0].uid == self.userId {
                        self.id = self.postKeepIngredient[0].id
                        self.keepForCell = self.postKeepIngredient[0].keepIngredient
                        self.firstTime = false
                    }
                }
                if self.firstTime {
                    let postRef = Database.database().reference().child("keepIngredient")
                    let id = postRef.childByAutoId().key
                    self.id = id
                    let postObject = [
                        "uid": userProfile.uid,
                        "username": userProfile.username,
                        "id": id,
                        "keepIngredient": ""
                        ] as [String:Any]
                    
                    postRef.child(id).setValue(postObject, withCompletionBlock: { error, ref in
                        if error == nil {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            // Handle the error
                        }
                    })
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! BuyIngredientCell
        cell.taskNameLabel.text = ingredients[indexPath.row].nameIngredient
        cell.checkImage.image = buyIngredientImageView[indexPath.item]
        
        var keepData = [String]()
        menuRef.observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let menufood = KeepIngredientForBuy(snapshot: child)
                    for name in menufood.keepIngredient {
                        if self.ingredients[indexPath.row].nameIngredient == name {
//                            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
//                            cell.ingredientState = true
                            //self.ingredients[indexPath.row].checkedIngredient = true
                        }
                    }
                }
            }
        })
        
        if ingredients[indexPath.row].checkedIngredient {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
            keepTaskName.append(ingredients[indexPath.row].nameIngredient)
            let TaskName = [
            "keepIngredient": keepTaskName
            ] as [String:Any]
        Database.database().reference().child("keepIngredient").child(self.id).updateChildValues(TaskName)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
            if(keepTaskName.count > 0) {
                var at = 0
                    for name in 0...keepTaskName.count-1 {
                        if keepTaskName[name] == ingredients[indexPath.row].nameIngredient {
                            at = name
                        }
                    }
                keepTaskName.remove(at: at)
                let TaskName = [
                "keepIngredient": keepTaskName
                ] as [String:Any]
            Database.database().reference().child("keepIngredient").child(self.id).updateChildValues(TaskName)
            }
        }
        cell.delegate = self
        cell.ingredients = ingredients
        cell.indexP = indexPath.row
        return cell
    }
    @IBAction func OkButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "BuyIngredient"
        if segue.identifier == iden {
            let buyIngredient = segue.destination as! SelectMenu
            buyIngredient.keepIngredient = keepTaskName
        }
    }
    
    func addTask(name: String) {
        ingredients.append(Ingredient(name: name))
        tableView.reloadData()
    }
    
    func checkBox(state: Bool, index: Int?) {
        ingredients[index!].checkedIngredient = state
        tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.none)
    }
    
}

class Ingredient {
    var nameIngredient = ""
    var checkedIngredient = false
    
    convenience init (name: String) {
        self.init()
        self.nameIngredient = name
    }
}

