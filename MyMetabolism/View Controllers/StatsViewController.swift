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

let docRef = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("time")
class StatsViewController: UIViewController{
    @IBOutlet weak var timeFinishLabel: UILabel!
    
    
    @IBOutlet weak var gradeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
  /*      docRef.getDocument(source: .cache) { (document, error) in
          if let document = document {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
            self.timeFinishLabel.text = document.get("time") as? String
            let timeFinish = document.get("time") as! String
            print(timeFinish)
          } else {
            print("Document does not exist")
          }
        }*/
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            self.timeFinishLabel.text = document.get("time") as? String
            let timeDocRef = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("arrTime")
            
            
            
            let timeFinish = document.get("time") as! String
            let timeArr : [String] = timeFinish.components(separatedBy: " ")
            var time : String = timeArr[0]
            var dayNight : String = timeArr[1]
            var timeSplit : [String] = time.components(separatedBy: ":")
            var hours : Int = Int(timeSplit[0]) ?? 0
            let decMins : String = "." + timeSplit[1]
            let mins = (decMins as NSString).floatValue
            let randomFloat = Float.random(in: 0.000001..<0.001)
            let totalTime = Float(hours) + mins + randomFloat
            //timeDocRef.setData(["timeList": [totalTime]])
            timeDocRef.updateData(["timeList" : FieldValue.arrayUnion([totalTime])])
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
            //print(timeFinish)
        }
    }
}

