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
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = signUpButton.bounds.height/2
        logInButton.layer.cornerRadius = logInButton.bounds.height/2
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "InsertMenu"
        if segue.identifier == iden {
            let insertMenuScreen = segue.destination as! InsertMenuScreen
        }
    }
    
    
}
