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
           
          
            //creates a new collection in firestore
            let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
   
            //adds input value into new collection in firestore as a new document
            var ref: DocumentReference? = Firestore.firestore().collection("users").document(currentUser())
            timeCollection.document("timeList").setData(["time\(counter)": totalTime2], merge: true) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }

            

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

