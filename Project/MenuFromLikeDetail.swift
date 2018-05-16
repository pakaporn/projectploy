//
//  MenuFromLikeDetail.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MenuFromLikeDetail: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "MenuFromLikeDetail"
        if segue.identifier == iden {
            let menuFronLikeDetail = segue.destination as! MenuFromLikeDetail
        }
    }
    
    
}

