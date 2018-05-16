//
//  CalenderScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class CalenderScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "Calender"
        if segue.identifier == iden {
            let calenderScreen = segue.destination as! CalenderScreen
        }
    }
    
    
}
