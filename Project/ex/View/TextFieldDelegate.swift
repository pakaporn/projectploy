//
//  TextFieldDelegate.swift
//  Project
//
//  Created by Pakaporn on 10/19/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

extension NewApptTableViewController: UITextFieldDelegate {
    
    func setTextFieldDelegates(){
        self.costTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


extension UpdateApptTVC: UITextFieldDelegate {
    func setTextFieldDelegates(){
        self.costTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


extension NewPatientTableVC: UITextFieldDelegate {
    
    func setTextFieldDelegates(){
        self.lastNameTextField.delegate = self
        self.nameTextField.delegate = self
        self.homePhoneTextField.delegate = self
        self.mobilePhoneTextField.delegate = self
        self.patientEmailTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}



