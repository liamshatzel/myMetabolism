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

let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime")

let today = getDayOfWeek()
var prev: Int = -1

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTimeButton.isEnabled = false
        
        //TODO: Fetch and determine if it has been 12 hrs since user has logged time finished
       
        let docRef = timeCollection.document("time")
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
           prev = document.get("dayOfWeek") as! Int
        }
        //TODO: Disable button if time already logged today.
        //if(today != prev){
                  // logTimeButton.isEnabled = true
          //  }

        //Notifications New Way
        NotificationCenter.default.addObserver(forName: .logInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let timePopUpVC = notification.object as! TimePopUpViewController
            self.timeLabel.text = timePopUpVC.formattedTime

            let changeableTime = Constants.time(changeableTime: timePopUpVC.formattedTime)

            timeCollection.document("time").setData(changeableTime.dictionary, merge: true)
        }
        Utilities.styleFilledButton(self.logTimeButton)
    
    }
    
  
    @IBAction func logTimeButton_TouchUpInside(_ sender: Any) {
        
    }
}

      










