//
//  LogInGmail.swift
//  Project
//
//  Created by Pakaporn on 5/16/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
///

import UIKit
import FirebaseAuth

class LogInGmail: BaseMenuController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = true 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInSelectorChanged(_ sender: Any) {
        
        isSignIn = !isSignIn
        
        if isSignIn{
            signInLabel.text = "Sign In"
            signInButton.setTitle("sign In", for: .normal)
        }
        else{
            signInLabel.text = "Registor"
            signInButton.setTitle("Registor", for: .normal)
        }
    }
    
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text ,  let pass = passwordTextField.text
        {
            
            if isSignIn{
                Auth.auth().signIn(withEmail: email, password: pass, completion: {(user , error ) in
                    
                    if let userLogin = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                    else{
                        
                    }
                })
            }
            else{
                Auth.auth().createUser(withEmail: email, password: pass, completion: {(user , error) in
                    
                    if let userLogin = user{
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                        
                    }
                    else{
                        
                    }
                })
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = "LogInGmail"
        if segue.identifier == iden {
            let logInGmail = segue.destination as! LogInGmail
        }
    }
    
    
}

    


    

