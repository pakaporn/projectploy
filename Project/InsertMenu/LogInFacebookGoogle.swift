//
//  LogInFacebook.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase

class LogInFacebookGoogle: BaseMenuController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButtons()
        setupGoogleButtons()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    fileprivate func setupFacebookButtons() {
        let loginFacebookButton = FBSDKLoginButton()
//        view.addSubview(loginFacebookButton)
//        loginFacebookButton.frame = CGRect(x: 40, y: 100, width: view.frame.width - 80, height: 50)
//        loginFacebookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        loginFacebookButton.delegate = self
        loginFacebookButton.readPermissions = ["email","public_profile"]
        
        let customFacebookButton = UIButton(type: .system)
        customFacebookButton.setBackgroundColor(color: .blue, forUIControlState: .normal)
        customFacebookButton.frame = CGRect(x: 40, y: 120, width: view.frame.width - 80, height: 50)
        customFacebookButton.setTitle("Continue with Facebook", for: .normal)
        customFacebookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFacebookButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFacebookButton)
        
        customFacebookButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        
    }
    
    fileprivate func setupGoogleButtons() {
        //let googleButton = GIDSignInButton()
        //googleButton.frame = CGRect(x: 40, y: 160, width: view.frame.width - 80, height: 50)
        //view.addSubview(googleButton)

        let customGoogleButton = UIButton(type: .system)
        customGoogleButton.frame = CGRect(x: 40, y: 220, width: view.frame.width - 80, height: 50)
        customGoogleButton.setBackgroundColor(color: .orange, forUIControlState: .normal)
        customGoogleButton.setTitle("Continue with Gmail Google", for: .normal)
        customGoogleButton.setTitleColor(.white, for: .normal)
        customGoogleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customGoogleButton.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        view.addSubview(customGoogleButton)

        GIDSignIn.sharedInstance().uiDelegate = self
    }

    @IBAction func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err)
                return
            }
            self.showEmailAddress()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else
        { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            print("Successfully logged in with our user: ", user ?? "")
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id,name,email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LogInFacebookGoogle"
        if segue.identifier == iden {
            let logInFacebook = segue.destination as! LogInFacebookGoogle
        }
    }
    
    
}
