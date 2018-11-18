//
//  CalenderViewController.swift
//  Project
//
//  Created by Pakaporn on 11/18/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

var dataString = ""

class CalenderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var calender: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let daysOfMonths = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonth = String()
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox = 0
    var direction = 0
    var positionIndex = 0
    var leapYearCounter = 2
    var dayCounter = 0
    var highLightDate = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = months[month]
        monthLabel.text = "\(currentMonth) \(year)"
        if weekday == 1 {
            weekday = 7
        }
        GetStartDateDayP0sition()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: Any) {
        highLightDate = -1
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            direction = 1
            
            if leapYearCounter < 5 {
                leapYearCounter += 1
            }
            if leapYearCounter == 4 {
                daysInMonths[1] = 29
            }
            if leapYearCounter == 5 {
                leapYearCounter = 1
                daysInMonths[1] = 28
            } //
            GetStartDateDayP0sition()
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calender.reloadData()
        default:
            direction = 1
            GetStartDateDayP0sition()
            month += 1
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calender.reloadData()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        highLightDate = -1
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            direction = -1
            if leapYearCounter > 0 {
                leapYearCounter -= 1
            }
            if leapYearCounter == 0 {
                daysInMonths[1] = 29
                leapYearCounter = 4
            } else {
                daysInMonths[1] = 28
            }
            GetStartDateDayP0sition()
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calender.reloadData()
        default:
            month -= 1
            direction = -1
            GetStartDateDayP0sition()
            currentMonth = months[month]
            monthLabel.text = "\(currentMonth) \(year)"
            calender.reloadData()
        }
    }
    
    func GetStartDateDayP0sition() {
        switch direction {
        case 0:
            numberOfEmptyBox = weekday
            dayCounter = day
            while dayCounter > 0 {
                numberOfEmptyBox = numberOfEmptyBox - 1
                dayCounter = dayCounter - 1
                if numberOfEmptyBox == 0 {
                    numberOfEmptyBox = 7
                }
            }
            if numberOfEmptyBox == 7 {
                numberOfEmptyBox = 0
            }
            positionIndex = numberOfEmptyBox
            
        case 1... :
            nextNumberOfEmptyBox = (positionIndex + daysInMonths[month])%7
            positionIndex = nextNumberOfEmptyBox
        case -1:
            previousNumberOfEmptyBox = (7 - (daysInMonths[month] - positionIndex)%7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch direction {
        case 0:
            return daysInMonths[month] + numberOfEmptyBox
        case 1... :
            return daysInMonths[month] + nextNumberOfEmptyBox
        case -1:
            return daysInMonths[month] + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calender", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.dateLabel.textColor = UIColor.black
        
        //cell.circle.isHidden = true
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch direction {
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.dateLabel.text!)! > 0 {
                cell.dateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        //        if currentMonth == months[calender.component(.month, from: date) - 1] && year == calender.component(.year, from: date) && indexPath.row + 1 == day {    //****
        //            cell.circle.isHidden = false
        //            cell.drawCircle()
        //        }
        //
        //        if highLightDate == indexPath.row {
        //            cell.backgroundColor = UIColor.blue
        //        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var numOfMonth = 0

        if currentMonth == "January" {
            numOfMonth = 1
        }else if currentMonth == "February" {
            numOfMonth = 2
        }else if currentMonth == "March" {
            numOfMonth = 3
        }else if currentMonth == "April" {
            numOfMonth = 4
        }else if currentMonth == "May" {
            numOfMonth = 5
        }else if currentMonth == "June" {
            numOfMonth = 6
        }else if currentMonth == "July" {
            numOfMonth = 7
        }else if currentMonth == "August" {
            numOfMonth = 8
        }else if currentMonth == "September" {
            numOfMonth = 9
        }else if currentMonth == "October" {
            numOfMonth = 10
        }else if currentMonth == "November" {
            numOfMonth = 11
        }else if currentMonth == "December" {
            numOfMonth = 12
        }
        
        dataString = "\(numOfMonth)/\(indexPath.row - positionIndex + 1)/\(year)"
        print(dataString)
        performSegue(withIdentifier: "NextView", sender: self)
        highLightDate = indexPath.row
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MealScreen = segue.destination as! MealScreen
        MealScreen.date = dataString
    }
}




