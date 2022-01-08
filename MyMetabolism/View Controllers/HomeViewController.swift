//
//  HomeViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

func currentUser() -> String{
    let user = Auth.auth().currentUser
    let uid = user!.uid
    return uid
}

let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("time")

let today = getDayOfWeek()

class HomeViewController: UIViewController {

    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!


    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        disableButton()
        //Get time value from pop up
        NotificationCenter.default.addObserver(forName: .logInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let timePopUpVC = notification.object as! TimePopUpViewController
            self.timeLabel.text = timePopUpVC.formattedTime
            
            //TODO: Fix forced unwraps
            
            let newTime = timeToFloat(timeString: timePopUpVC.formattedTime)
            timeCollection.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.get("totalTime") ?? 0.0
                    print("Document data: \(dataDescription)")
                    
                    let localCount: Int = (document.get("count") as! Int) + 1
                    let oldTime = dataDescription as! Float
                    let localTotal: Float = oldTime + newTime
                    let avg: Float = Float(localTotal / Float(localCount))
                    let changeableTime = Constants.time(changeableTime: timePopUpVC.formattedTime, overallAverage: avg, count: localCount, totalTime: localTotal)
                        
                    timeCollection.setData(changeableTime.dictionary, merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written! here")
                        }
                    }
                } else {
                    print("Document does not exist yet")
                    //initializes document if it doesnt exist
                    let changeableTime = Constants.time(changeableTime: "00:00 AM", overallAverage: 0.0, count: 1, totalTime: 0.0)
                        
                    timeCollection.setData(changeableTime.dictionary, merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written! here")
                        }
                    }
                }

            }
        }
        Utilities.styleFilledButton(self.logTimeButton)
    }
    
    @IBAction func logTimeButton_TouchUpInside(_ sender: Any) {
        let timeList = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
        NotificationCenter.default.addObserver(forName: .logInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let timePopUpVC = notification.object as! TimePopUpViewController
            timeList.document("\(Date())").setData(["time": timeToFloat(timeString: timePopUpVC.formattedTime), "date": Date()]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func disableButton(){
        var prev: Int = -1
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            //UNCOMMENT FOR FUNCTIONALITY
            
            //prev = document.get("dayOfWeek") as! Int? ?? -1
            if(prev == today){
                self.logTimeButton.isEnabled = false
            }
        }
    }
}

      










