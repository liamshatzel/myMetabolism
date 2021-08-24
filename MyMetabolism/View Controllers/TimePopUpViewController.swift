//
//  TimePopUpViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 8/24/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation
import UIKit

class TimePopUpViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var logButton: UIButton!
    
    var formattedTime: String{
        get {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: timePicker.date)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    @IBAction func logButton_TouchUpInside(_ sender: Any) {
        NotificationCenter.default.post(name: .logInfo, object: self)
        
        dismiss(animated: true)
    }
    
}
