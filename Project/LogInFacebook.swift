//
//  LogInFacebook.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class LogInFacebook: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LogInFacebook"
        if segue.identifier == iden {
            let logInFacebook = segue.destination as! LogInFacebook
        }
    }
    
    
}
