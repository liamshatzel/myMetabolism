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
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            self.timeFinishLabel.text = document.get("time") as? String
           
            
            
            //Formats the date into a string and then into a float
            let timeFinish = document.get("time") as! String
            let timeArr : [String] = timeFinish.components(separatedBy: " ")
            var time : String = timeArr[0]
            var dayNight : String = timeArr[1]
            var timeSplit : [String] = time.components(separatedBy: ":")
            var hours : Int = Int(timeSplit[0]) ?? 0
            let decMins : String = "." + timeSplit[1]
            let mins = (decMins as NSString).floatValue
            
            print(count)
            let totalTime = Float(hours) + mins
            let totalTime2 = String(totalTime)
           
          
            //references time collection in firestore
            let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
   
            //adds input value into new collection in firestore as a new document
          
            var ref: DocumentReference? = Firestore.firestore().collection("users").document(currentUser())
            timeCollection.document("timeList").setData(["time": timeFinish], merge: true) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            //implementing current day dictionary
         
            var weekdayDict : [String : Any] = [
                    
                          "7": "00",
                          "6": "00",
                          "5": "00",
                          "4": "00",
                          "3": "00",
                          "2": "00",
                          "1": "00"
                          ]
            
            //var dayOfWeek : String = " "
            let today = String(getDayOfWeek()!)
//            switch today {
//            case 7:
//                dayOfWeek = "mon"
//            case 6:
//                dayOfWeek = "tues"
//            case 5:
//                dayOfWeek = "wed"
//            case 4:
//                dayOfWeek = "thurs"
//            case 3:
//                dayOfWeek = "fri"
//            case 2:
//                dayOfWeek = "sat"
//            case 1:
//                dayOfWeek = "sun"
//            default:
//                dayOfWeek = "-"
//            }
            
            
           // weekdayDict[today] = time
            
            /*timeCollection.document("time").setData(["id" : "uid", "times" : [
            
                  "7": "00",
                  "6": "00",
                  "5": "00",
                  "4": "00",
                  "3": "00",
                  "2": "00",
                  "1": "00"
                  ]])*/
            timeCollection.document("time").getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    weekdayDict = document.data()!
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
/*
            timeCollection.document("time").updateData(["times.": "\(time)"])
             { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
*/
            
            print("today" + String(getDayOfWeek()!))
            
            

            print(totalTime)
            if (dayNight == "PM"){
                hours = hours + 12
            }
            
            switch hours {
            case 11...18:
                self.gradeLabel.text = "A"
                print("A")
            case 19...20:
                self.gradeLabel.text = "B"
                print("B")
            case 21...22:
                self.gradeLabel.text = "C"
                print("C")
            case 22..<23:
                self.gradeLabel.text = "D"
                print("D")
            default:
                self.gradeLabel.text = "F"
                print("F")
            }
            
            print(hours)
            print(mins)
            print(time)
            print(dayNight)
        }
    }
}

