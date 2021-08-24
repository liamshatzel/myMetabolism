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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(handlePopUpClosing), name: .logInfo, object: nil)
        
        //Notifications New Way
        NotificationCenter.default.addObserver(forName: .logInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let timePopUpVC = notification.object as! TimePopUpViewController
            self.timeLabel.text = timePopUpVC.formattedTime
        }

        
    }
    
   // @objc func handlePopUpClosing(notification: Notification){
  //  let timePopUpVC = notification.object as! TimePopUpViewController
  //      timeLabel.text = timePopUpVC.formattedTime
    //}
}

      











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
