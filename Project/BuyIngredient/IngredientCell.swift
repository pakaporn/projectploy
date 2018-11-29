//
//  IngredientCell.swift
//  Project
//
//  Created by Pakaporn on 11/7/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //storyLabel.text = ""
        // Configure the view for the selected state
    }
}
