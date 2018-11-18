//
//  MenuPopular.swift
//  Project
//
//  Created by Pakaporn on 10/5/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import Firebase

class MenuPopular {
    
    var menu: String = ""
    var ingredient: String = ""
    var method: String = ""
    var category: String = ""
    var numberOfLikes = 0
    let ref: DatabaseReference!
    
    
    init(menu: String, ingredient: String, method: String, category: String) {
        self.menu = menu
        self.ingredient = ingredient
        self.method = method
        self.category = category
        ref = Database.database().reference().child("menuPopular").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as?  [String: Any] {
            menu =  value["menu"] as! String
            ingredient =  value["ingredient"] as! String
            method =  value["method"] as! String
            // category = value["category"] as! String
            // numberOfLikes = value["numberOfLikes"] as! Int
        }
    }
    
    func getName() -> String {
        return menu
    }
    
    func getIngredient() -> String {
        return ingredient
    }
    
    func getMethod() -> String {
        return method
    }
    
    func getCategory() -> String {
        return category
    }
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "menu": menu,
            "ingredient": ingredient,
            "method": method,
            //"numberOfLikes": numberOfLikes
        ]
    }
}

extension MenuPopular {
    func like() {
        numberOfLikes += 1
        ref.child("numberOfLikes").setValue(numberOfLikes)
    }
}




