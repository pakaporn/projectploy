//
//  MyMenuCell.swift
//  Project
//
//  Created by Pakaporn on 7/7/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class MyMenuCell: UITableViewCell {
    
    fileprivate let likeColor = UIColor(red: 243.0/255.0, green: 62.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var storyLabel: UILabel!
    
    var menufood: MenuDetail! {
        didSet {
            storyLabel.text = menufood.text
            likeButton.setTitle("😍 \(menufood.numberOfLikes)", for: [])
            likeButton.layer.cornerRadius = likeButton.bounds.height/2
            
        }
    }
    
    @IBAction func likeDidTouch(_ sender: AnyObject)
    {
        menufood.like()
        likeButton.setTitle("😍 \(menufood.numberOfLikes)", for: [])
        likeButton.setTitleColor(likeColor, for: [])
    }
}
