//
//  InsertMyMenu.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class InsertMyMenu: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "InsertMyMenu"
        if segue.identifier == iden {
            let insertMyMenu = segue.destination as! InsertMyMenu
        }
    }
    
    
}
