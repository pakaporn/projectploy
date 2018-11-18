//
//  MenuFavorite.swift
//  Project
//
//  Created by Pakaporn on 9/11/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import Firebase

class MenuCalender {
    var id: String = ""
    var menu: String = ""
    var ingredient: String = ""
    var method: String = ""
    var category: String = ""
    var photoURL = ""
    var date = ""
    var meals = ""
    let ref: DatabaseReference!
    
    init(menu: String, ingredient: String, method: String, category: String) {
        self.menu = menu
        self.ingredient = ingredient
        self.method = method
        self.category = category
        ref = Database.database().reference().child("menuCalendar").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String: Any] {
            id = value["id"] as! String
            menu =  value["menu"] as! String
            ingredient =  value["ingredient"] as! String
            method =  value["method"] as! String
            category = value["kindOFfood"] as! String
            photoURL = value["photoURL"] as! String
            date = value["date"] as! String
            meals = value["meals"] as! String
            
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
            "category": category,
            "photoURL": photoURL
            //"numberOfLikes": numberOfLikes
        ]
    }
}

extension MenuFavorite {
//    func like() {
//        numberOfLikes += 1
//        ref.child("numberOfLikes").setValue(numberOfLikes)
//    }
}



