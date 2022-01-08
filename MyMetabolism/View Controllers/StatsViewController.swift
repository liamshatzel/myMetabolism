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
    let minRound: Int = Int(min)! % 60
    min = String(format: "%02d", minRound)
    var hourNum = Int(time) as Int
    var dayNight = ""
    print(hourNum)
    
    if(hourNum >= 24){
        hourNum -= 12
        hour = String(hourNum)
        dayNight = "AM"
    }else if(hourNum > 12){
        hourNum -= 12
        hour = String(hourNum)
        dayNight = "PM"
    }else{
        hour = String(hourNum)
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
        
        //Sets the timeLabel text when there are no real entries
        func setTimeLabel(){
            print("time == 00")
            let timeRef = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
            timeRef.whereField("date", isNotEqualTo: 0).order(by: "date").limit(to: 1).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let timeDone = timeFormat(document.get("time") as! Float)
                        self.timeFinishLabel.text = timeDone
                    }
                }
            }
        }
        
        //Fetches document from Firestore and Sets timeLabel as time set
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            let getTime = document.get("overallAverage") as! Float?
            if (Float(getTime ?? 0.0) == 0.0) {
                setTimeLabel()
            } else {
                let timeFinish = timeFormat(getTime ?? 0.0)
                self.timeFinishLabel.text = timeFinish
            }
            
            switch getTime ?? 0.0{
            case 11...18:
                self.gradeLabel.text = "😀"
            case 19...20:
                self.gradeLabel.text = "🙂"
            case 21...22:
                self.gradeLabel.text = "😐"
            case 22..<23:
                self.gradeLabel.text = "😬"
            default:
                self.gradeLabel.text = "😳"
            }
        }
    }
}

