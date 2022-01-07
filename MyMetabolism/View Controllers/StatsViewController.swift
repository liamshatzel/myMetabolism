//
//  StatsViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 8/26/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//Firestore Document Location
let docRef = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("time")

var count : Float = 0


func getDayOfWeek() -> Int? {
    let todayDate = Date()
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
}

func timeFormat(_ time: Float) -> String{
    let retVal = String (format: "%.2f", time)
    let formatted: [String] = (retVal.components(separatedBy: "."))
    var hour = formatted[0]
    var min = formatted[1]
    let minRound: Int = Int(min)! % 59
    min = String(format: "%02d", minRound)
    var hourNum = Int(time) as Int
    var dayNight = ""
    if(hourNum > 12){
        hourNum -= 12
        hour = String(hourNum)
        dayNight = "PM"
    } else {
        dayNight = "AM"
    }
    return "\(hour):\(min) \(dayNight)"
}

func timeToFloat(timeString: String) -> Float{
    //From string into time and AM/PM
    let timeArr: [String] = timeString.components(separatedBy: " ")
    let time : String = timeArr[0]
    let dayNight : String = timeArr[1]
    
    //Into hours and minutes
    let timeSplit : [String] = time.components(separatedBy: ":")
    var hours : Int = Int(timeSplit[0]) ?? 0
    if dayNight == "PM" && hours != 12{
        hours += 12
    } else if hours == 12 && dayNight == "AM" {
        hours += 12
    }
    let decMins : String = "." + timeSplit[1]
    let mins = (decMins as NSString).floatValue
    return Float(hours) + mins
}

class StatsViewController: UIViewController{
    @IBOutlet weak var timeFinishLabel: UILabel!
    
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Fetches document from Firestore and Sets timeLabel as time set
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            let getTime = document.get("overallAverage") as! Float?
            let timeFinish = timeFormat(getTime ?? 0.0)
            self.timeFinishLabel.text = timeFinish
            
            //Formats the date into a string and then into a float
            
            switch getTime ?? 0.0{
            case 11...18:
                self.gradeLabel.text = "😀"
                print("😀")
            case 19...20:
                self.gradeLabel.text = "🙂"
                print("🙂")
            case 21...22:
                self.gradeLabel.text = "😐"
                print("😐")
            case 22..<23:
                self.gradeLabel.text = "😬"
                print("😬")
            default:
                self.gradeLabel.text = "😳"
                print("😳")
            }
        }
    }
}

