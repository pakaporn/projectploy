//
//  MenuViewController.swift
//  Project
//
//  Created by Pakaporn on 8/15/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import Firebase

class MenuViewController: BaseMenuController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        logoImageView.layer.cornerRadius = logoImageView.bounds.height/4
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}

