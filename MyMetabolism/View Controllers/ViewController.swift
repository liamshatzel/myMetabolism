//
//  ViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var desc1: UILabel!
    
    @IBOutlet weak var desc2: UILabel!
    
    @IBOutlet weak var introText: UILabel!
    

    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            // [START_EXCLUDE]
            if Auth.auth().currentUser != nil {
                let HomeViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController)
                let HomeViewNC = UINavigationController(rootViewController: HomeViewTab!)
                
                let AcctViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.acctViewController)
                let AcctViewNC = UINavigationController(rootViewController: AcctViewTab!)
                
                let StatsViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.statsViewController)
                let StatsViewNC = UINavigationController(rootViewController: StatsViewTab!)
                
                let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                self.tabBarController?.viewControllers = [HomeViewNC, StatsViewNC, AcctViewNC]
                
                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
       
            } else {
                print ("not signed in")
                
              
            }
            // [END_EXCLUDE]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupElements()
        
        //intro text styling
        introText.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)


        
        //description 1 styling
        desc1.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)

//description 2 styling
        
        desc2.alpha = 0.7

        desc2.textColor = UIColor(red: 0.176, green: 0.047, blue: 0.341, alpha: 1)

    }
    func setupElements(){
        //Style Buttons
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
        }
    
    

}

