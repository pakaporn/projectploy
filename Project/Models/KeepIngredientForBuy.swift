//
//  KeepIngredientForBuy.swift
//  Project
//
//  Created by Pakaporn on 11/21/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class KeepIngredientForBuy {
    //var user = UserProfileStruct()
    var id: String!
    var uid: String!
    var username: String!
    var keepIngredient = [String]()
    var forKeepIngredient: String!
    let ref: DatabaseReference!
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let value = snapshot.value as!  [String: Any]
        self.id =  value["id"] as! String
        self.uid = value["uid"] as! String
        self.username =  value["username"] as! String
        if value["keepIngredient"] != nil {
            
            if let item = value["keepIngredient"] {
                if item is String {
                    self.keepIngredient.append(item as! String)
                } else if item is [String] {
                    self.keepIngredient = item as! [String]
                }
            }
            //self.keepIngredient = value["keepIngredient"] as! [String]
            //self.forKeepIngredient = value["keepIngredient"] as! String
            //self.keepIngredient.append(forKeepIngredient)
            //print(self.keepIngredient)
        }
    }
    
}

