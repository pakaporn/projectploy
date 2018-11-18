//
//  Menu.swift
//  Project
//
//  Created by Pakaporn on 7/3/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import Foundation
import Firebase

class MenuDetail {
    
    var id: String = ""
    var fromId: String?
    var toId: String?
   // var timestamp: NSNumber?
    var text: String = ""
    var ingredient: String = ""
    var method: String = ""
    var category: String = ""
    var numberOfLikes = 0
    let ref: DatabaseReference!
    
    init(fromId: String, toId: String, id: String, text: String, ingredient: String, method: String, category: String) {
        self.id = id
        self.fromId = fromId
        self.toId = toId
        //self.timestamp = timestamp
        self.text = text
        self.ingredient = ingredient
        self.method = method
        self.category = category
        ref = Database.database().reference().childByAutoId().child("menu")
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as?  [String: Any] {
            id = value["id"] as! String
            fromId = value["fromId"] as? String
            toId = value["toId"] as? String
            text =  value["text"] as! String
            ingredient =  value["ingredient"] as! String
            method =  value["method"] as! String
            category = value["category"] as! String
            numberOfLikes = value["numberOfLikes"] as! Int
        }
    }
    
    func getId() -> String {
        return id
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
    
    func getCategory() -> String {
        return category
    }
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "text": text,
            "ingredient": ingredient,
            "method": method,
            "category": category,
            "numberOfLikes": numberOfLikes
        ]
    }
    
//    func chatPartnerId() -> String? {
//        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
//    }
}

extension MenuDetail {
    func like() {
        numberOfLikes += 1
        ref.child("numberOfLikes").setValue(numberOfLikes)
    }
}

