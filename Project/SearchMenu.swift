//
//  SearchMenu.swift
//  Project
//
//  Created by Pakaporn on 5/17/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class SearchMenu: BaseMenuController  {

    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "SearchMenu"
        if segue.identifier == iden {
            let searchMenu = segue.destination as! SearchMenu
        }
    }
    
}


