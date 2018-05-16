//
//  LogOutScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class LogOutScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "Logout"
        if segue.identifier == iden {
            let logOutScreen = segue.destination as! LogOutScreen
        }
    }
    
    
}
