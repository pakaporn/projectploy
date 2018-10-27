
//
//  Post.swift
//  Project
//
//  Created by Pakaporn on 8/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import Foundation
import Firebase

class Post {
    var id: String
    var author: UserProfile
    var text: String = ""
    var createdAt: Date
    
    init(id: String, author: UserProfile, text: String, timestamp: Double) {
        self.id = id
        self.author = author
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }

    
}
