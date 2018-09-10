//
//  MenuPopularDetail.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit

class MenuPopularDetail: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuPopularDetail"
        if segue.identifier == iden {
            let menuPopularDetail = segue.destination as! MenuPopularDetail
        }
    }
    
    
}
