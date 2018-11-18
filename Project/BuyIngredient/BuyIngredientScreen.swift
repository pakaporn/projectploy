//
//  BuyIngredientScreen.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//
import UIKit

class BuyIngerdientScreen: BaseMenuController, UITableViewDelegate, UITableViewDataSource, AddTask, CheckBox {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let buyIngredientImageView: [UIImage] = [
        UIImage(named: "chicken")!,
        UIImage(named: "chop")!,
        UIImage(named: "fish")!,
        UIImage(named: "egg")!,
        UIImage(named: "egg")!,
        UIImage(named: "chili")!,
        UIImage(named: "lemon")!,
        UIImage(named: "lemon")!,
        UIImage(named: "lemon")!,
        UIImage(named: "cabbage")!
    ]
    
    var ingredients: [Ingredient] = [Ingredient(name: "ไก่"), Ingredient(name: "หมู"), Ingredient(name: "ปลา"), Ingredient(name: "ไข่ไก่"), Ingredient(name: "ไข่เป็ด"), Ingredient(name: "พริก"), Ingredient(name: "มะนาว"), Ingredient(name: "ใบกระเพรา"), Ingredient(name: "ผักชี"), Ingredient(name: "กะหล่ำปลี")]
    var keepTaskName: [String] = []
    
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
        
        if ingredients[indexPath.row].checkedIngredient {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControlState.normal)
            keepTaskName.append(ingredients[indexPath.row].nameIngredient)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }
        cell.delegate = self
        cell.ingredients = ingredients
        cell.indexP = indexPath.row
        return cell
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

