//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        //button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        
        button.backgroundColor = UIColor(red: 0.043, green: 0.808, blue: 0.514, alpha: 1)
        //button.layer.cornerRadius = 25.0
        button.layer.cornerRadius = 14
        button.tintColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: 327, height: 54)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.frame = CGRect(x: 0, y: 0, width: 327, height: 54)
        //button.layer.borderWidth = 2
        
        button.tintColor = UIColor(red: 0.043, green: 0.808, blue: 0.514, alpha: 1)
        button.backgroundColor = .white
        //button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 14.0
        //button.tintColor = UIColor.black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
