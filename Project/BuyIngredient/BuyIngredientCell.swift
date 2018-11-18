//
//  BuyIngredientCell.swift
//  Project
//
//  Created by Pakaporn on 10/30/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

protocol CheckBoxBuyIngredient {
    func checkBox(state: Bool, index: Int?)
}

class BuyIngredientCell: UITableViewCell {
    
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
    var ingredients: [Ingredient]?
}

