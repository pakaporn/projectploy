//
//  Menu.swift
//  Project
//
//  Created by Pakaporn on 7/3/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import Firebase

class MenuDetail {
    var text: String = ""
    var ingredient: String = ""
    var method: String = ""
    var numberOfLikes = 0
    let ref: DatabaseReference!
    
    
    init(text: String,ingredient: String,method: String) {
        self.text = text
        self.ingredient = ingredient
        self.method = method
        ref = Database.database().reference().child("mymenu").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as?  [String: Any] {
            text =  value["text"] as! String
            ingredient =  value["ingredient"] as! String
            method =  value["method"] as! String
            numberOfLikes = value["numberOfLikes"] as! Int
        }
    }
    
    func getName() -> String {
        return text
    }
    
    func getIngredient() -> String {
        return ingredient
    }
    
    func getMethod() -> String {
        return method
    }
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "ingredient": ingredient,
            "method": method,
            "numberOfLikes": numberOfLikes
        ]
    }
}

extension MenuDetail {
    func like() {
        numberOfLikes += 1
        ref.child("numberOfLikes").setValue(numberOfLikes)
    }
}

