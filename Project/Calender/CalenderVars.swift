//
//  CalenderVars.swift
//  Project
//
//  Created by Pakaporn on 11/18/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation

let date = Date()
let calender = Calendar.current
let day = calender.component(.day, from: date)
var weekday = calender.component(.weekday, from: date)
var month = calender.component(.month, from: date) - 1
var year = calender.component(.year, from: date)

