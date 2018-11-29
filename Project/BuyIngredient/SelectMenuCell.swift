//
//  SelectMenuCell.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class SelectMenuCell: UITableViewCell {
    
    fileprivate let likeColor = UIColor(red: 243.0/255.0, green: 62.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var storyLabel: UILabel!
    var ref: DatabaseReference?
    
    var menufood: Post! {
        didSet {
            storyLabel.text = menufood.menu
            likeButton.setTitle("😍 \(menufood.numberOfLikes)", for: [])
            likeButton.layer.cornerRadius = likeButton.bounds.height/6
        }
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if ingredients![indexP!].checkedIngredient {
            delegate?.checkBox(state: false, index: indexP)
        } else {
            delegate?.checkBox(state: true, index: indexP)
        }
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet var checkImage: UIImageView!
    
    var indexP: Int?
    var delegate: CheckBox?
    var ingredients: [KeepPost]?
    
}

