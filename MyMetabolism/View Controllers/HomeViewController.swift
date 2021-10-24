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
//var now : Date? = nil
var counter = 0
var timer = Timer()
var isCounting = false

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        //Notifications New Way
        NotificationCenter.default.addObserver(forName: .logInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let timePopUpVC = notification.object as! TimePopUpViewController
            self.timeLabel.text = timePopUpVC.formattedTime
            

            let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime")
            

            let changeableTime = Constants.time(changeableTime: timePopUpVC.formattedTime)

            timeCollection.document("time").setData(changeableTime.dictionary, merge: true)


        }

        
    }
    
    @IBAction func logTimeButton_TouchUpInside(_ sender: Any) {
        
        count = count + 0.001
        let now = Date()
        let later  = Date().addingTimeInterval(30)
        if (later <= now){
            logTimeButton.isEnabled = false
            
            
        
        }
    }
    
    @objc func updateTimer(){
        counter = counter - 28800
    }

}

      










