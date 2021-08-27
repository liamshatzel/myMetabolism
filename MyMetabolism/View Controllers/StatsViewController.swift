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
            let timeFinish = document.get("time") as! String
            print(timeFinish)
        }
    }
}
