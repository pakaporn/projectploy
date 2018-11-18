//
//  UserProfile.swift
//  Project
//
//  Created by Pakaporn on 8/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import Foundation

class UserProfile {
    var uid: String
    var username: String
    var photoURL: URL
    
    init(uid: String, username: String, photoURL: URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }

    func getUid() -> String {
        return uid
    }
    
    func getUsername() -> String {
        return username
    }
    
    func getPhotoURL() -> String {
        return photoURL.absoluteString
    }
}

