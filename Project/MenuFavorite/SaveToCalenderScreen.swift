//
//  SaveToCalenderScreen.swift
//  Project
//
//  Created by Pakaporn on 10/10/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit
import Firebase

class SaveToCalenderScreen: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var mealTextField: UITextField!
    private var datePicker: UIDatePicker!
    
    var menu = ""
    var ingredient = ""
    var method = ""
    var photoURL = ""
    var keepCategory = ""
    var keepMeals = ""
    var KeepDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SaveToCalenderScreen.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SaveToCalenderScreen.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        inputTextField.inputView = datePicker
        
        createMealPicker()
        createToolBar()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let meals = ["Breakfast",
                 "Lunch",
                 "Dinner"
    ]
    var selectedMeal: String?
    
    func createMealPicker() {
        let mealPicker = UIPickerView()
        mealPicker.delegate = self
        mealTextField.inputView = mealPicker
        //mealPicker.backgroundColor = .black
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //toolBar.barTintColor = .black
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SaveToCalenderScreen.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        mealTextField.inputAccessoryView = toolBar
        inputTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SaveToCalenderScreen: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return meals[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMeal = meals[row]
        mealTextField.text = selectedMeal
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        }
        else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.text = meals[row]
        return label
    }
    
    @IBAction func handlePostButton() {
            // Firebase code here
            let postRef = Database.database().reference().child("menuCalendar")
            let key = postRef.childByAutoId().key
            let postObject = [
                "id": key,
                "menu": self.menu ,
                "ingredient": self.ingredient,
                "method": self.method,
                "kindOFfood": self.keepCategory,
                "photoURL": photoURL,
                "date" : inputTextField.text ?? "",
                "meals" : mealTextField.text ?? ""
                ] as [String:Any]
            
            //print(postObject)
            postRef.child(key).setValue(postObject, withCompletionBlock: { error, ref in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // Handle the error
                }
            })
    }
}





