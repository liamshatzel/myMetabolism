//
//  ViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var desc1: UILabel!
    
    @IBOutlet weak var desc2: UILabel!
    
    @IBOutlet weak var introText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupElements()
        
        //intro text styling
        introText.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)

        //introText.font = UIFont(name: "Lato-Bold", size: 24)
        
        //description 1 styling
        desc1.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)

        //desc1.font = UIFont(name: "SFPro-Bold", size: 18)
        
        //description 2 styling
        desc2.alpha = 0.7

        desc2.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)

        //desc2.font = UIFont(name: "SFPro-Regular", size: 16)
        
        /*//Display all font families
         for family in UIFont.familyNames.sorted() {
               let names = UIFont.fontNames(forFamilyName: family)
               print("Family: \(family) Font names: \(names)")
        }*/
    }
    func setupElements(){
        //Style Buttons
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
        }


}

