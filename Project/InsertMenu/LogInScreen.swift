//
//  LogInScreen.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit

class LogInScreen: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var loginGmailButton: UIButton!
    @IBOutlet var loginFacebookButton: UIButton!
//    var loginGmail: RoundedWhiteButton!
//    var activityView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginGmailButton.layer.cornerRadius = loginGmailButton.bounds.height/2
        loginFacebookButton.layer.cornerRadius = loginFacebookButton.bounds.height/2
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
//        loginGmail = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        loginGmail.setTitleColor(secondaryColor, for: .normal)
//        loginGmail.setTitle("LoginGmail", for: .normal)
//        loginGmail.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
//        loginGmail.center = CGPoint(x: view.center.x, y: view.frame.height - loginGmail.frame.height - 24)
//        loginGmail.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
//        loginGmail.defaultColor = UIColor.white
//        loginGmail.addTarget(self, action: #selector(menuView), for: .touchUpInside)
//        loginGmail.alpha = 0.5
//        view.addSubview(loginGmail)
//          setLoginGmail(enabled: false)
//
//        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        activityView.color = secondaryColor
//        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
//        activityView.center = loginGmail.center
//
//        view.addSubview(activityView)
        self.navigationController?.hidesBarsOnSwipe = true
    }
//    @objc func menuView() {
//        //setLoginGmail(enabled: false)
//        loginGmail.setTitle("", for: .normal)
//        activityView.startAnimating()
//        self.dismiss(animated: false, completion: nil)
//        activityView.stopAnimating()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LogInScreen"
        if segue.identifier == iden {
            let logInScreen = segue.destination as! LogInScreen
        }
    }
}





