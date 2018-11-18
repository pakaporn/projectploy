//
//  MealScreen.swift
//  Project
//
//  Created by Pakaporn on 11/12/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class MealScreen: BaseMenuController {

    var date = ""
    var meals = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(date)
        let idenBreakfastScreen = "BreakfastScreen"
        let idenLunchScreen = "LunchScreen"
        let idenDinnerScreen = "DinnerScreen"
        if segue.identifier == idenBreakfastScreen {
            let calenderDetail = segue.destination as! BreakfastScreen
            calenderDetail.date = date
            //calenderDetail.meal = meals
        } else if segue.identifier == idenLunchScreen {
            let calenderDetail = segue.destination as! LunchScreen
            calenderDetail.date = date
            //calenderDetail.meal = meals
        } else if segue.identifier == idenDinnerScreen {
            let calenderDetail = segue.destination as! DinnerScreen
            calenderDetail.date = date
            //calenderDetail.meal = meals
        }
    }

}
