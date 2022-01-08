//
//  Unused.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 9/4/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation



// FROM HOME VIEW CONTROLLER

   /*   NotificationCenter.default.addObserver(self, selector: #selector(handlePopUpClosing), name: .logInfo, object: nil)
      view.layer.backgroundColor = UIColor(red: 0.965, green: 0.961, blue: 0.961, alpha: 1).cgColor
  }
  
 @objc func handlePopUpClosing(notification: Notification){
     let popUpVC = notification.object as! ProfileViewController
      //timeLabel.text =
}*/


/*picker.dataSource = self
picker.delegate = self*/
// Do any additional setup after loading the view.

/*  @IBOutlet weak var picker: UIPickerView!
  
  let hours = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  
  let minutes = ["00" , "01" , "02" , "03" , "04" , "05" , "06" , "07" , "08" , "09" , "10" , "11" , "12" , "13" , "14" , "15" , "16" , "17" , "18" , "19" , "20" , "21" , "22" , "23" , "24" , "25" , "26" , "27" , "28" , "29" , "30" , "31" , "32" , "33" , "34" , "35" , "36" , "37" , "38" , "39" , "40" , "41" , "42" , "43" , "44" , "45" , "46" , "47" , "48" , "49" , "50" , "51" , "52" , "53" , "54" , "55" , "56" , "57" , "58" , "59"]
  let dayNight = ["AM", "PM"] */

/*extension HomeViewController: UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component){
        case 0:
            return 12;
        case 1:
            return 59;
        case 2:
            return 2;
        default:
            return 2;
        }
    }
    
    
}

extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component){
        case 0:
            return hours[row];
        case 1:
            return minutes[row];
        case 2:
            return dayNight[row];
        default:
            return "error";
        }
    }
}
*/


  // @objc func handlePopUpClosing(notification: Notification){
//  let timePopUpVC = notification.object as! TimePopUpViewController
//      timeLabel.text = timePopUpVC.formattedTime
  //}


//timer = Timer.scheduledTimer(timeInterval: 28800, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)


   //  NotificationCenter.default.addObserver(self, selector: #selector(handlePopUpClosing), name: .logInfo, object: nil)


// let collection = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid)
 //let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime")
// let timeDocument = Firestore.firestore().collection("users").document(currentUser())


//            let timeFinished = Constants.LogTime(
//               user: Auth.auth().currentUser!.uid,
//               time: timePopUpVC.formattedTime, firstname: firstname, lastname: lastname, uid: Auth.auth().currentUser!.uid
//           )


            //var ref: DocumentReference? = timeDocument
            
//            timeCollection.addDocument(data: Constants.LogTime.dictionary) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                }
//            }

          //print(currentUser())

          
          //timeCollection.addDocument(data: changeableTime.dictionary, merge: true)


//VIEW CONTROLLER

/*  private func validateAuth() {
      if Auth.auth().currentUser != nil{
         HomeViewController()
      } else{
          let vc = LoginViewController()
          let nav = UINavigationController(rootViewController: vc)
          nav.modalPresentationStyle = .fullScreen
          present(nav, animated: false)
      }
  } */

//desc2.font = UIFont(name: "SFPro-Regular", size: 16)

/*//Display all font families
 for family in UIFont.familyNames.sorted() {
       let names = UIFont.fontNames(forFamilyName: family)
       print("Family: \(family) Font names: \(names)")
}*/

//desc1.font = UIFont(name: "SFPro-Bold", size: 18)

        //introText.font = UIFont(name: "Lato-Bold", size: 24)


   //let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController) as? TabBarContoller
   //self.view.window?.rootViewController = tabBarController
   //self.view.window?.makeKeyAndVisible()

/*let signUpViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
              self.view.window?.rootViewController = signUpViewController
              self.view.window?.makeKeyAndVisible()*/



// STATS VIEW CONTROLLER

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


 //let timeDocRef = Firestore.firestore().collection("users").document(currentUser()).collection("finishTime").document("arrTime")

//let randomFloat = Float.random(in: 0.000001..<0.001)

 //timeDocRef.setData(["timeList": [totalTime]])

            //timeDocRef.updateData(["time" : FieldValue.arrayUnion([totalTime])])



//implementing current day dictionary
//Formats week number into string representation
// var dayOfWeek : String = " "

//   let today = Int(getDayOfWeek()!)
//
//   switch today {
//   case 7:
//       dayOfWeek = "mon"
//   case 6:
//       dayOfWeek = "tues"
//   case 5:
//       dayOfWeek = "wed"
//   case 4:
//       dayOfWeek = "thurs"
//   case 3:
//       dayOfWeek = "fri"
//   case 2:
//       dayOfWeek = "sat"
//   case 1:
//       dayOfWeek = "sun"
//   default:
//       dayOfWeek = "-"
//   }

//            var weekdayDict : [String : Any] = [
//
//                          "7": "00",
//                          "6": "00",
//                          "5": "00",
//                          "4": "00",
//                          "3": "00",
//                          "2": "00",
//                          "1": "00"
//                          ]
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
/*
 timeCollection.document("time").updateData(["times.": "\(time)"])
 { err in
 if let err = err {
 print("Error updating document: \(err)")
 } else {
 print("Document successfully updated")
 }
 
 */

//print("today " + String(getDayOfWeek()!))



//print(totalTime)
//            if (dayNight == "PM"){
//                hours = hours + 12
//            }

//        docRef.addSnapshotListener { documentSnapshot, error in
//            guard let document = documentSnapshot else {
//                print("Error fetching document: \(error!)")
//                return
//            }
//            let timeFinish = document.get("time") as! String?
//
//            guard let timeFinishString: String = (timeFinish) else {return}
//
//
//            //references time collection in firestore
//            let timeCollection = Firestore.firestore().collection("users").document(currentUser()).collection("timeList")
//
//
//            //adds input value into new collection in firestore as a new document
//            let ref: DocumentReference? = Firestore.firestore().collection("users").document(currentUser())
//
//            timeCollection.addDocument(data: ["time": timeToFloat(timeString: timeFinishString), "date": Date()]) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                }
//            }
//         }


            //TODO: Add logic to query data and create a weighted average of times
            
//            timeCollection.document("time").getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    //weekdayDict = document.data()!
//                    print("Document data: \(dataDescription)")
//                } else {
//                    print("Document does not exist")
//                }
//            }

            //TODO: Make single average variable, only needs one read, then write overall average to firestore, repeat each time.
            //No need to query, simply update average each time. Do I need a global count?
            
//            var tot: Float = 0
//
//            let timeQuery = timeCollection.whereField("time", isNotEqualTo: NSNull())
//               timeQuery.getDocuments() { (querySnapshot, err) in
//                   if let err = err {
//                       print("Error getting documents: \(err)")
//                   } else {
//                       for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.get("time"))")
//                        count += 1
//                        tot += document.get("time") as! Float
//                    }
//                        let ovr = tot/count
//
//                        switch ovr {
//                        case 11...18:
//                            self.gradeLabel.text = "😀"
//                            print("😀")
//                        case 19...20:
//                            self.gradeLabel.text = "🙂"
//                            print("🙂")
//                        case 21...22:
//                            self.gradeLabel.text = "😐"
//                            print("😐")
//                        case 22..<23:
//                            self.gradeLabel.text = "😬"
//                            print("😬")
//                        default:
//                            self.gradeLabel.text = "😳"
//                            print("😳")
//                        }
//                        self.timeFinishLabel.text = timeFormat(ovr)
//                        print(tot/count)
//                   }
//               }

