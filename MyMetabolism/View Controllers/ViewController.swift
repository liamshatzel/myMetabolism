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
                
            //let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController) as? TabBarContoller
            //self.view.window?.rootViewController = tabBarController
            //self.view.window?.makeKeyAndVisible()
            } else {
                print ("not signed in")
                
                /*let signUpViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
                self.view.window?.rootViewController = signUpViewController
                self.view.window?.makeKeyAndVisible()*/
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


}

