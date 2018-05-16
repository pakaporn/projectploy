//
//  InsertMenuScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class InsertMenuScreen: BaseMenuController {
  
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "InsertMenu"
        if segue.identifier == iden {
            let insertMenuScreen = segue.destination as! InsertMenuScreen
        }
    }
    
    
}
