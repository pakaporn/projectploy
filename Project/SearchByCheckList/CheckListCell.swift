//
//  TaskCell.swift
//  Project
//
//  Created by Pakaporn on 9/22/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

protocol CheckBox {
    func checkBox(state: Bool, index: Int?)
}

class CheckListCell: UITableViewCell {
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
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
    var tasks: [Tasks]?
}
