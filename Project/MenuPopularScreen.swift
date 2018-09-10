//
//  MenuPopularScreen.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MenuPopularScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    func setUpMenuButton(){
        let menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuButton.setImage(UIImage(named:"menu"), for: .normal)
        
        let menuBarItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuPopular"
        if segue.identifier == iden {
            let menuPopularScreen = segue.destination as! MenuPopularScreen
        }
    }
    
    
}

