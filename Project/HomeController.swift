//
//  HomeController.swift
//  Project
//
//  Created by Pakaporn on 5/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class HomeController: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openMenuScreen(_ sender: UIButton) {
        let btnTitle = sender.currentTitle!
        
        self.revealViewController().rearViewController.performSegue(withIdentifier: btnTitle, sender: self.revealViewController().rearViewController)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "Home"
        if segue.identifier == iden {
            let homeController = segue.destination as! HomeController
        }
    }
    
}
