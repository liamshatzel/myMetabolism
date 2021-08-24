//
//  PopUpViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 8/23/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    

    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var logButton: UIButton!

    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    @IBAction func logTime_TouchUpInside(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name.logInfo, object: self)
        
        dismiss(animated: true)
    }
    
}

