//
//  MenuFavouriteScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MenuFavouriteScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuFavourite"
        if segue.identifier == iden {
            let menuFavouriteScreen = segue.destination as! MenuFavouriteScreen
        }
    }
    
    
}
